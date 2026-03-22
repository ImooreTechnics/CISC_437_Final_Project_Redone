CREATE OR REPLACE TRIGGER TRG_CREATE_FOOTPRINT 
AFTER CREATE ON <YOUR SCHEMA>.SCHEMA 
declare
  V_SQL VARCHAR2(2000);
  function does_col_exist(table_name_in varchar2, column_name_in varchar2)
  return number
  as
  v_cnt number(1);
  begin
    select count(*) into v_cnt from user_tab_cols
    where table_name =  table_name_in
    and column_name = column_name_in;
    
    return v_cnt;
  end;
  

begin
    IF ORA_DICT_OBJ_TYPE = 'TABLE' THEN
        if does_col_exist(ora_dict_obj_name, 
                ora_dict_obj_name || '_CRTD_ID') = 0 THEN
            V_SQL := 'ALTER TABLE ' || ora_dict_obj_name || ' ADD (' || ora_dict_obj_name || '_CRTD_ID VARCHAR2(40) NOT NULL )';
            EXECUTE IMMEDIATE V_SQL;        
        END IF;
        
        if does_col_exist(ora_dict_obj_name, 
                ora_dict_obj_name || '_CRTD_DT') = 0 THEN
            V_SQL := 'ALTER TABLE ' || ora_dict_obj_name || ' ADD (' || ora_dict_obj_name || '_CRTD_DT DATE NOT NULL )';
            EXECUTE IMMEDIATE V_SQL;        
        END IF;
        
        if does_col_exist(ora_dict_obj_name, 
                ora_dict_obj_name || '_UPDT_ID') = 0 THEN
            V_SQL := 'ALTER TABLE ' || ora_dict_obj_name || ' ADD (' || ora_dict_obj_name || '_UPDT_ID VARCHAR2(40) NOT NULL )';
            EXECUTE IMMEDIATE V_SQL;        
        END IF;
        
        if does_col_exist(ora_dict_obj_name, 
                ora_dict_obj_name || '_UPDT_DT') = 0 THEN
            V_SQL := 'ALTER TABLE ' || ora_dict_obj_name || ' ADD (' || ora_dict_obj_name || '_UPDT_DT DATE NOT NULL) ';
            EXECUTE IMMEDIATE V_SQL;        
        END IF;
    END IF;
END;