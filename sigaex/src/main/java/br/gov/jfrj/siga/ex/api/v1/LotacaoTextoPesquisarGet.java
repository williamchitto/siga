package br.gov.jfrj.siga.ex.api.v1;

import java.util.ArrayList;
import java.util.List;

import br.gov.jfrj.siga.base.Texto;
import br.gov.jfrj.siga.dp.DpLotacao;
import br.gov.jfrj.siga.dp.dao.DpLotacaoDaoFiltro;
import br.gov.jfrj.siga.ex.api.v1.IExApiV1.ILotacaoTextoPesquisarGet;
import br.gov.jfrj.siga.ex.api.v1.IExApiV1.LotacaoTextoPesquisarGetRequest;
import br.gov.jfrj.siga.ex.api.v1.IExApiV1.LotacaoTextoPesquisarGetResponse;
import br.gov.jfrj.siga.ex.api.v1.IExApiV1.ResultadoDePesquisa;
import br.gov.jfrj.siga.ex.api.v1.TokenCriarPost.Usuario;
import br.gov.jfrj.siga.hibernate.ExDao;

public class LotacaoTextoPesquisarGet implements ILotacaoTextoPesquisarGet {

	@Override
	public void run(LotacaoTextoPesquisarGetRequest req,
			LotacaoTextoPesquisarGetResponse resp) throws Exception {
		String authorization = TokenCriarPost.assertAuthorization();
		Usuario u = TokenCriarPost.assertUsuario();

		resp.list = new ArrayList<>();
		final DpLotacaoDaoFiltro flt = new DpLotacaoDaoFiltro();
		flt.setNome(Texto.removeAcentoMaiusculas(req.texto));
		//TODO: ver se precisa de outros parametros listarLotacoes
		List<DpLotacao> l = ExDao.getInstance().consultarPorFiltro(flt);
		
		for (DpLotacao p : l) {
			ResultadoDePesquisa rp = new ResultadoDePesquisa();
			rp.nome = p.getNomeLotacao();
			rp.sigla = p.getSiglaCompleta();
			resp.list.add(rp);
		}


	}

	@Override
	public String getContext() {
		return "selecionar pessoas";
	}
}