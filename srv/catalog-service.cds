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
            ID,
            Name           as ProductName,
            Description,
            ImageUrl,
            ReleaseDate,
            DiscontinuedDate,
            Price,
            Height,
            Width,
            Depth,
            Quantity,
            UnitOfMeasures as ToUnitOfMeasure,
            Currency       as ToCurrency,
            Category       as ToCategory,
            Category.Name  as Category,
            DimensionUnit  as ToDimensionUnit,
            SalesData,
            Supplier,
            Reviews
        };

    entity Supplier          as
        select from cg.sales.Suppliers {
            ID,
            Name,
            Email,
            Phone,
            Fax,
            Product as ToProduct
        };

    entity Review            as
        select from cg.sales.SalesData {
            ID,
            DeliveryDate,
            Revenue,
            Currency.ID               as CurrencyKey,
            DeliveryMonth.ID          as DeliveryMonthId,
            DeliveryMonth.Description as DeliveryMonth,
            Product                   as ToProduct
        }

    entity StockAvailability as
        select from cg.materials.StockAvailability {
            ID,
            Description,
            Product as ToProduct
        };

    entity VH_Categories     as
        select from cg.materials.Categories {
            ID   as Code,
            Name as Text
        };

    entity VH_Currencies     as
        select from cg.materials.Currencies {
            ID          as Code,
            Description as Text
        };

    entity VH_UnitOfMeasure  as
        select from cg.materials.UnitOfMeasures {
            ID          as Code,
            Description as Text
        };

    entity VH_DimensionUnits as
        select from cg.materials.DimensionUnits {
            ID          as Code,
            Description as Text
        };
}
