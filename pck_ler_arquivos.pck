create or replace package elias.pck_ler_arquivos is

  -- Author  : elias
  -- Created : 05/05/2021 15:24:10
  
  procedure stp_ler_arquivo(p_nome_arquivo in varchar2,
                           p_erro out varchar2);
                           
end;

create or replace package body elias.pck_ler_arquivos is

  c_dir_orig   constant      varchar2(50) := '/link/pasta';
  c_dir_name   constant      varchar2(200)  := 'DIR_NAME';

  
  procedure stp_ler_arquivo(p_nome_arquivo in varchar2,
                            p_erro out varchar2) is
    v_col1 varchar2(14);
    v_col2 varchar2(14);
    v_col3 varchar2(2);
    v_col4 varchar2(6);
    v_col5 varchar2(3);
    v_col6 varchar2(3);
    v_col7 number(16,3);
    v_col8 number(15,4);
    v_col9 number(15,2);
    v_col10 number(16,3);
    v_col11 number(15,2);
    v_col12 number(15,4);
    v_col13 number(16,3);
    v_col14 number(16,3);
    v_col15 number(15,2);
    v_col16 number(16,3);
    v_col17 number(16,3);
    v_col18 number(16,3);
    v_col19 number(16,3);
    v_col20 number(15,4);
    v_col21 number(15,2);
    
    arquivo_txt utl_file.file_type;
    v_linha varchar2(400);
    eof boolean := false;
    
  begin
    
    arquivo_txt := utl_file.fopen(c_dir_name , p_nome_arquivo, 'r');
    while not (eof) loop
      begin
          utl_file.get_line(arquivo_txt, v_linha);
          
          if v_linha like ';%' then
            continue;
          elsif v_linha = '' then
            continue;
          end if;
          
          for r1 in (
              select 
                 regexp_substr(v_linha, '[^|]+', 1, level) as texto,
                 rownum
              from dual 
              connect by regexp_substr(v_linha, '[^|]+', 1, level) is not null) 
          
          loop
               if r1.rownum = 1 then
                 v_col1 := r1.texto;
               elsif r1.rownum = 2 then
                 v_col2 := r1.texto;
               elsif r1.rownum = 3 then
                 v_col3 := r1.texto;
               elsif r1.rownum = 4 then
                 v_col4 := r1.texto;
               elsif r1.rownum = 5 then
                 v_col5 := r1.texto;
               elsif r1.rownum = 6 then
                 v_col6 := r1.texto;
               elsif r1.rownum = 7 then
                 v_col7 := to_number(r1.texto,'9999999999999999.999');
               elsif r1.rownum = 8 then
                 v_col8 := to_number(r1.texto,'9999999999999999.9999');
               elsif r1.rownum = 9 then
                 v_col9 := to_number(r1.texto,'9999999999999999.99');
               elsif r1.rownum = 10 then
                 v_col10 := to_number(r1.texto,'9999999999999999.999');
               elsif r1.rownum = 11 then
                 v_col11 := to_number(r1.texto,'9999999999999999.99');
               elsif r1.rownum = 12 then
                 v_col12 := to_number(r1.texto,'9999999999999999.9999');
               elsif r1.rownum = 13 then 
                 v_col13 :=  to_number(r1.texto,'9999999999999999.999');
               elsif r1.rownum = 14 then
                 v_col14 := to_number(r1.texto,'9999999999999999.999');
               elsif r1.rownum = 15 then
                 v_col15 :=  to_number(r1.texto,'9999999999999999.99');
               elsif r1.rownum = 16 then
                 v_col16 :=  to_number(r1.texto,'9999999999999999.999');
               elsif r1.rownum = 17 then
                 v_col17 :=  to_number(r1.texto,'9999999999999999.999');
               elsif r1.rownum = 18 then
                 v_col18 :=  to_number(r1.texto,'9999999999999999.999');
               elsif r1.rownum = 19 then 
                 v_col19 :=  to_number(r1.texto,'9999999999999999.999');
               elsif r1.rownum = 20 then
                 v_col20 :=  to_number(r1.texto,'9999999999999999.9999');
               elsif r1.rownum = 21 then
                 v_col21 :=  to_number(substr(r1.texto,1,length(r1.texto)-1),'9999999999999999.99'); --no arquivo tem um /n na ultima linha
               end if;
          
          end loop;
          
          insert into elias.tabela
          select
            v_col1,
            v_col2 ,
            v_col3,
            v_col4,
            v_col5,
            v_col6,
            v_col7,
            v_col8,
            v_col9,
            v_col10,
            v_col11,
            v_col12,
            v_col13,
            v_col14,
            v_col15,
            v_col16,
            v_col17,
            v_col18,
            v_col19,
            v_col20,
            v_col21
          from dual;
          
          
      exception
        when no_data_found then
          eof := true;
        
      end;
    end loop;
    
    p_erro := 'N';
    return;
          
  end;
  
  
end;

