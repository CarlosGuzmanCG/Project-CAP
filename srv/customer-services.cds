using {products.db as cg} from '../db/schema';

service CusomerService {
    entity CustomerSrv as projection on cg.Customer;
}
