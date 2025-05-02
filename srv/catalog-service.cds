using {com.cg as cg} from '../db/schema';
using {com.training as training} from '../db/training';

// service CatalogService {
//     entity Products as projection on cg.materials.Products;
//     entity Suppliers as projection on cg.sales.Suppliers;

//     entity Currency as projection on cg.materials.Currencies;
//     entity DimensionUnit as projection on cg.materials.DimensionUnits;
//     entity Category as projection on cg.materials.Categories;
//     entity SalesData as projection on cg.sales.SalesData;
//     entity Reviews as projection on cg.materials.ProductReview;

//     entity Order as projection on cg.sales.Orders;
//     entity OrderItem as projection on cg.sales.OrderItems;

//     entity UnitOfMeasures as projection on cg.materials.UnitOfMeasures;
//     entity Months as projection on cg.sales.Months;
// }

define service CatalogService {

    entity Products          as
        select from cg.materials.Products {
            // ID,
            // Name           as ProductName @mandatory,
            // Description @mandatory,
            // ImageUrl,
            // ReleaseDate,
            // DiscontinuedDate,
            // Price @mandatory,
            // Height,
            // Width,
            // Depth,
            *,
            Quantity,
            UnitOfMeasures as ToUnitOfMeasure @mandatory,
            Currency       as ToCurrency      @mandatory,
            Category       as ToCategory      @mandatory,
            Category.Name  as Category        @readonly,
            DimensionUnit  as ToDimensionUnit,
            SalesData,
            Supplier,
            Reviews
        };

    @readonly
    entity Supplier          as
        select from cg.sales.Suppliers {
            ID,
            Name,
            Email,
            Phone,
            Fax,
            Product as ToProduct
        };

    @readonly
    entity SalesData         as
        select from cg.sales.SalesData {
            ID,
            DeliveryDate,
            Revenue,
            Currency.ID               as CurrencyKey,
            DeliveryMonth.ID          as DeliveryMonthId,
            DeliveryMonth.Description as DeliveryMonth,
            Product                   as ToProduct
        }

    @readonly
    entity StockAvailability as
        select from cg.materials.StockAvailability {
            ID,
            Description,
            Product as ToProduct
        };

    @readonly
    entity VH_Categories     as
        select from cg.materials.Categories {
            ID   as Code,
            Name as Text
        };

    @readonly
    entity VH_Currencies     as
        select from cg.materials.Currencies {
            ID          as Code,
            Description as Text
        };

    @readonly
    entity VH_UnitOfMeasure  as
        select from cg.materials.UnitOfMeasures {
            ID          as Code,
            Description as Text
        };

    @readonly
    entity VH_DimensionUnits as
        select
            ID          as Code,
            Description as Text
        from cg.materials.DimensionUnits;
}

define service MyService {
    entity SuppliersProduct as
        select from cg.materials.Products[Name = 'Bread']{
            *,
            Name,
            Description,
            Supplier.Address
        }
        where
            Supplier.Address.PostalCode = 98074;

    entity SupliersToSales  as
        select
            Supplier.Email,
            Category.Name,
            SalesData.Currency.ID,
            SalesData.Currency.Description
        from cg.materials.Products;

    entity EntityInfix      as
        select Supplier[Name = 'Exotic Liquids'].Phone from cg.materials.Products
        where
            Products.Name = 'Bread';

    entity EntityJoin       as
        select Phone from cg.materials.Products
        left join cg.sales.Suppliers as Supp
            on(
                Supp.ID = Products.Supplier.ID
            )
            and Supp.Name = 'Exotic Liquids'
        where
            Products.Name = 'Bread';

}

define service Reports  {

    entity AverageRating as projection on cg.reports.AverageRating;

}