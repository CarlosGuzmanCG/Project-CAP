namespace com.cg;

using {
    cuid,
    managed //add 4 fields to the table -> common.cds

} from '@sap/cds/common';


define type Name : String(50);

type Address {
    Street     : String;
    City       : String;
    State      : String(2);
    PostalCode : String(5);
    Country    : String(3);
};

type Dec         : Decimal(16, 2);

context materials {


    entity Products : cuid, managed {
        //key ID               : UUID;
        Name             : localized String not null; //default 'NoName';
        Description      : localized String;
        ImageUrl         : String;
        ReleaseDate      : DateTime default $now;
        //creationDate     : Date default CURRENT_DATE;
        DiscontinuedDate : DateTime;
        Price            : Dec;
        Height           : type of Price; //Decimal(16, 2);
        Width            : Decimal(16, 2);
        Depth            : Decimal(16, 2);
        Quantity         : Decimal(16, 2);

        // Unmanaged Associations
        // Supplier_Id      : UUID;
        // ToSupplier       : Association to one Suppliers // Unmanaged Associations
        //                        on ToSupplier.ID = Supplier_Id;
        // UnitOfMeasure_id  : String(2);
        // ToUnitOfMeasure  : Association to UnitOfMeasures // Unmanaged Associations
        //                        on ToUnitOfMeasure.ID = UnitOfMeasure_id;

        //Managed Associations
        Supplier         : Association to one sales.Suppliers;
        UnitOfMeasures   : Association to UnitOfMeasures;
        Currency         : Association to Categories;
        DimensionUnit    : Association to DimensionUnits;
        Category         : Association to Categories;
        //Association Many
        SalesData        : Association to many sales.SalesData
                               on SalesData.Product = $self;
        Reviews          : Association to many ProductReview
                               on Reviews.Product = $self;

    //Fields manager
    // createdAt        : Timestamp  @cds.on.insert: $now;
    // createdBy        : User       @cds.on.insert: $user;
    // modifiedAt       : Timestamp  @cds.on.insert: $now   @cds.on.update: $now;
    // modifiedBy       : User       @cds.on.insert: $user  @cds.on.update: $user;
    };

    entity Categories {
        key ID   : String(1);
            Name : localized String;
    };

    entity StockAvailability {
        key ID          : Integer;
            Description : localized String;
            Product     : Association to Products;
    };

    entity Currencies {
        key ID          : String(3);
            Description : localized String;
    };

    entity UnitOfMeasures {
        key ID          : String(2);
            Description : localized String;
    };

    entity DimensionUnits {
        key ID          : String(2);
            Description : localized String;
    };

    entity ProductReview : cuid, managed {
        //key ID      : UUID;
        Name    : String;
        Rating  : String;
        Comment : String;
        Product : Association to Products;
    };

    entity SelProducts   as select from Products;

    //View in base of projection

    entity ProjProducts  as projection on Products;

    entity ProjProducts2 as
        projection on Products {
            *
        };

    entity ProjProducts3 as
        projection on Products {
            ReleaseDate,
            Name
        };

    // entity ProjParamProducts(pName : String) as projection on Products where Name = : pName;
    //Extension
    extend Products with {
        PriceCondition     : String(2);
        PriceDetermination : String(3);
    };

}

context sales {
    //Composition
    entity Orders : cuid {
        //key ID       : UUID;
        Date     : Date;
        Customer : String;
        Item     : Composition of many OrderItems
                       on Item.Order = $self;
    };

    entity OrderItems : cuid {
        //key ID       : UUID;
        Order    : Association to Orders;
        Product  : Association to  materials.Products;
        Quantity : Integer;
    }
    //*-----*

    entity Suppliers : cuid, managed {
        //key ID      : UUID;
        Name    : type of materials.Products : Name; //String;
        Street  : String;
        Address : Address;
        Email   : String;
        Phone   : String;
        Fax     : String;
        Product : Association to many materials.Products
                      on Product.Supplier = $self;
    };

    entity Months {
        key ID               : String(2);
            Description      : localized String;
            ShortDescription : localized String(3);
    };

    entity SelProducts1 as
        select from materials.Products {
            *
        };

    entity SelProducts2 as
        select from materials.Products {
            Name,
            Price,
            Quantity
        };

    //Database level view
    entity SelProducts3 as
        select from materials.Products
        left join materials.ProductReview
            on Products.Name = ProductReview.Name
        {
            Rating,
            Products.Name,
            sum(Price) as TotalPrice
        }
        group by
            Rating,
            Products.Name
        order by
            Rating;


    entity SalesData : cuid, managed {
        //key ID            : UUID;
        DeliveryDate  : DateTime;
        Revenue       : Decimal(16, 2);
        Product       : Association to materials.Products; //Managed Associations
        Currency      : Association to materials.Currencies; //Managed Associations
        DeliveryMonth : Association to sales.Months; //Managed Associations
    };

}
