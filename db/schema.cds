namespace com.cg;

define type Name : String(50);

type Address {
    Street     : String;
    City       : String;
    State      : String(2);
    PostalCode : String(5);
    Country    : String(3);
};

// type EmailAddress_01: many{ Type matriz of array of
//     kind : String;
//     email : String;
// };

// type EmailAddress_02{
//     kind : String;
//     email : String;
// };

// entity Emails {
//     email_01 : EmailAddress_01;
//     email_02 : many EmailAddress_02;
//     email_03 : many {
//         kind : String;
//         email : String;
//     }
// };

// type Gender : String enum{
//     male;
//     femele;
// };

// entity Order {
//     clienGender : Gender;
//     Status : Integer enum {
//         submitted = 1;
//         fulfiller = 2;
//         shipped = 3;
//         cancel = -1;
//     };
//     priority : String @assert.range enum {
//         high;
//         medium;
//         low;
//     }
// };

// entity Car {
//     key ID                 : UUID;
//         name               : String;
//         virtual discount_1 : Decimal;
//         @Core.Computed: false
//         virtual discount_2 : Decimal;
// };

type Dec         : Decimal(16, 2);

entity Products {
    key ID               : UUID;
        Name             : String not null; //default 'NoName';
        Description      : String;
        ImageUrl         : String;
        ReleaseDate      : DateTime default $now;
        //creationDate     : Date default CURRENT_DATE;
        DiscontinuedDate : DateTime;
        Price            : Dec;
        Height           : type of Price; //Decimal(16, 2);
        Width            : Decimal(16, 2);
        Depth            : Decimal(16, 2);
        Quantity         : Decimal(16, 2);
};

entity Suppliers {
    key ID         : UUID;
        Name       : type of Products : Name; //String;
        Street     : String;
        City       : String;
        State      : String(2);
        PostalCode : String(5);
        Country    : String(3);
        Email      : String;
        Phone      : String;
        Fax        : String;
};

entity Suppliers_01 {
    key ID      : UUID;
        Name    : String;
        Address : Address;
        Email   : String;
        Phone   : String;
        Fax     : String;
};

entity Suppliers_02 {
    key ID      : UUID;
        Name    : String;
        Address : {
            Street     : String;
            City       : String;
            State      : String(2);
            PostalCode : String(5);
            Country    : String(3);
        };
        Email   : String;
        Phone   : String;
        Fax     : String;
};

entity Categories {
    key ID   : String(1);
        Name : String;
};

entity StockAvailability {
    key ID          : Integer;
        Description : String;
};

entity Currencies {
    key ID          : String(3);
        Description : String;
};

entity UnitOfMeasuures {
    key ID          : String(2);
        Description : String;
};

entity DimensionUnits {
    key ID          : String(2);
        Description : String;
};

entity Months {
    key ID               : String(2);
        Description      : String;
        ShortDescription : String(3);
};

entity ProductReview {
    key Name    : String;
        Rating  : String;
        Comment : String;
};

entity SalesData {
    key ID           : UUID;
        DeliveryDate : DateTime;
        Revenue      : Decimal(16, 2);
};

entity SelProducts   as select from Products;

entity SelProducts1  as
    select from Products {
        *
    };

entity SelProducts2  as
    select from Products {
        Name,
        Price,
        Quantity
    };

//Database level view
entity SelProducts3  as
    select from Products
    left join ProductReview
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


// Entities with Parameters

// entity ParamProducts(pName : String) as
//     select from Products{
//         Name,
//         Price, 
//         Quantity
//     }
//     where Name = : pName;

// entity ProjParamProducts(pName : String) as projection on Products where Name = : pName;

extend Products with {
    PriceCondition: String(2);
    PriceDetermination: String(3);
};