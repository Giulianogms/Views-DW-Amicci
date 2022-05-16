
SELECT QP.SEQPRODUTO PLU, QP.PRODUTO DESCRICAO, DPC.CODACESSO EAN, 
       QC.CATEGORIA_NIVEL_1 N1, QC.CATEGORIA_NIVEL_2 N2, QC.CATEGORIA_NIVEL_3 N3, QC.CATEGORIA_NIVEL_4 N4, QC.CATEGORIA_NIVEL_5 N5,
       CASE WHEN UPPER(QP.MARCA) LIKE '%NAGUMO%' THEN '1' 
            WHEN UPPER(QP.MARCA) = 'PADARIA' THEN '1'
            WHEN UPPER(QP.MARCA) = 'ROTISSERIA' THEN '1' ELSE '0' END MARCA_PROPRIA,
       QP.FORNECEDOR_PRINCIPAL FORNECEDOR, QP.SEQFORNECEDOR_PRINCIPAL CODFORNEC,
       LPAD(DFR.NROCGCCPF,12,0)||LPAD(DFR.DIGCGCCPF,2,0) CNPJ_FORNEC, QP.MARCA,
       CASE WHEN QP.SEQPRODUTO IN (SELECT DISTINCT SEQPRODUTO FROM DIM_PRODUTOEMPRESA QPR WHERE QPR.STATUSVENDA = 'A') THEN 'Ativo' ELSE 'Inativo' END STATUS_VDA
    /* Quando o produto estiver ativo em qualquer empresa constará como 'ATIVO' */

FROM QLV_PRODUTO QP LEFT JOIN DIM_PRODUTOCODIGO DPC ON QP.SEQPRODUTO = DPC.SEQPRODUTO AND DPC.QTDEMBALAGEM = 1 AND DPC.TIPCODIGO = 'E'
                    LEFT JOIN QLV_CATEGORIA     QC  ON QP.SEQFAMILIA = QC.SEQFAMILIA
                    LEFT JOIN DIM_FORNECEDOR    DFR ON QP.SEQFORNECEDOR_PRINCIPAL = DFR.SEQFORNECEDOR;
