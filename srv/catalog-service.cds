using {com.cg as cg} from '../db/schema';

service CatalogService {
    entity Products as projection on cg.Products;
    entity Suppliers as projection on cg.Suppliers;
    entity Suppliers_01 as projection on cg.Suppliers_01;
}
