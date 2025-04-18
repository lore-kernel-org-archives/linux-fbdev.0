Received: from sonic312-23.consmr.mail.gq1.yahoo.com (sonic312-23.consmr.mail.gq1.yahoo.com [98.137.69.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEA421128A
	for <linux-fbdev@vger.kernel.org>; Fri, 18 Apr 2025 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.69.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744989500; cv=none; b=CN/AYyabATJr3DtGmvz5V92ueAYWptkbdcJjvXaB1JyS7lhzFdsI2tBIX1EXemaP4BP/cYNCXCvd0jTL9RDHvfZLvOriUWB5sJXQkv0ePK9NG+04Z2a8BrOf7jaXm2hO794vMk3bRXxXich3CNxPye8aAdgParTPYgi7XLOG8/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744989500; c=relaxed/simple;
	bh=KGdCXFt+x2n6fsL0TovYryn10LuTDD0aICC+QlM3f0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=PgOzTrm4kujdG2uty4p15hv/4XZ4mg+OPRKXCW0s49Xurj21tS+d9w2y1U5/+eaIQE9i35fXsWCwSgslDfw8FkXG5XewISdsHUiPv5WnMUpCJdzZJZf86f77fuPQpaOcaRJIwMGgFbGRTm7rzBAffYPUtRgJHJEyu9crjWjifnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com; spf=pass smtp.mailfrom=aol.com; dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b=pcBwGho1; arc=none smtp.client-ip=98.137.69.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aol.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="pcBwGho1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1744989496; bh=YOwYVS88MYAo67yBk8FKZOYEK4G5ffDyYrmi+VNm9T4=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=pcBwGho1KrPf+8SZnZv3EGdFIInQLrYT9CbHTBJcjlStTCnwB7Rm0agVOSkmBXJTQ9B/yoQjxiIcRTuTe3bQV4qUv/QQJJ07VL/tLOPyAwqPNbIWN73W9EIFMYstw8HoyyHgIx2eEg2GfaD1WUuSk0kpF8pCe8JwRcnmYqcZyXBehHUGFB9LKP2flqy6WS3WeZbD2f110EVrT+B0oJA9HhpQgqRl/rv8XXltSpF1/esUN9Itzz8SVlrhcZh14TXiNapWZpJT1KpFibRhQogLx8uyV74IUE0uwk6qbhUE1UEvB419Lr0SZYkI4YobWwFweA/T92DAfCvWutQDhswYyg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1744989496; bh=zJ3/FTRP2qP44OO1CSeP46q820reB7DNH2s5NzWuWhU=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=UanUR6ea81LovmOsFEdHz1vtr4ql1Qj9ueHzBY9HQZnH0R3QcIwRscsuoPR67FxUpRwxs7JPWp8Uxk1Jl6PLwV4I1sjyseM/o/5kBKWIWRZUDudGklC1ihy6pg6nvGZ8yyecgOxAeqPXEpH/4a9t1oOODsvBaD1yRGOfuBgqV/pDv+sqb3EfgYDJGOLridTY5ayTBavNcgFm3NdVdyCQAkPEFv3TJmXYuB6bXuOpnG++ywCojtNiDS8K433ptFkixGbWUAnsZNZWLxvoCay0aW24TCahkriRSypCuNniB2or9wJ4hSXTlIla6aEY4n9HRY3o8H1TGmENDA+M9XmDMA==
X-YMail-OSG: iHH0dwwVM1nt69Zn6Jdicsz0N0Gni1kNY29AuggnVNYVfkx2qF.2n_BKrKOquFc
 qcDq7KCuvqQT9fn_Vw.Yknqew.rTNOo1sE7orarwLdRsSRgoVUopnIMkDmkP146jjrwDnnOXanym
 aWlT.Hg6I98vuX_AGJ89WZAhzbmz1ke1_UcpUlMA10QjbxeE8VgkTPBf3WNHtOFfShON.lYdIybe
 gl5Zl28oczstcMSNeEs82sg0d2K3Sc7d9cHbjuxmc_NQAsYHm5bHDD6lKwVAml0nYUqFPahhZTJK
 qP4klKz7q6XGLvOZMsfYcO4hP5TCR1Z8BacVkyK9uj69WjaHGzM43oKQa090X0RyIjcKI6jEMn4d
 84JvKqOJ1D1uA8I6e1TvxPvurK8bdU2awWdbR7_TJL.We5ZVJLHJKQTCNNGtioWxriDz2JO15qkl
 kXng66DyqaQNYD7B4m189IiFNKE7_cN.SDkFGKnvSxMB8pfXfk19bObzCFIgvv9lGjhRxW68d6bk
 0lg5Z617ouWZXpxeLMSJ1aWjo9i2DLPLVg8Jvj3XsmBiumb3mGfsP5cdFoeE1HTdrVBDw5P21Fsz
 nLcuOGSqb6ydHgidSS1ErdfA4255ZwiEkuagpW1a1Gj.wxsiyYJwA8Qubv7Sv_pHX8ubue5K6Vez
 G_uLINbulkIS9ZfnwG9SCRDTrYVjbotK7q_hHwz4gzdQcu7JDir95ZR9rJM8.xFR8HOEHEV7zVUe
 2KiZaREhY2ZTQ2DwKSv3KSvTWCdj9TX75fsySCZDsP7TBiQ3hjpJobsufacihelZ6tXbdv_Iyb4v
 vDswOr549lrYJrw.gP4W3l2itqjSwwFnBAi0o2W8EL5XKROXJlMiL_fiox7SXedozGwMjOkTH1fX
 JHbrccvZMdtbx_Ai8KF3aFfWF.JM51Ew2YJ2PCfRxTopII2_zpljFXD.zKiFVMxGZx8vzAcoR7CK
 _.GyGJdVhen_KgxtWiCljZfLSqTzklsHf5CsdolafJ0RVTBvj6dNOwMXQ6P_Cyt_wimO0WNu2O46
 O42COvH8ksF5n2UcHbVXrAVQubDItLAPDWexRyv8emfJG6YnBlbDYgSuUrP0D4NDV8Wp0J1kacwo
 lwoIyuHs5GAhufuDZvn9_IyC1knfa2ua_2y6xEzr5ICCXEDyG7aowggZMeleIli7EQoaderf9yCY
 su2VJyR6KVvJaZmK28O1mu6CfuTQhBJgZV68IsBLDFAU95wy7nSsn.KPbuLfR1RbL8BvEL8riZ.s
 KoZXFIEyo2uJ.t9hAHQMocZi45OlazELB1Z5reB79g2HyUMwlsxZt0sLvjdn6iiSBhDc5aTTetew
 UiAlsURDZXr4OA5iP0Ri9yz8ZI6FBqTsJyXzQWdveLu.LigY1gbOlfmM.MLrjmltZZI2OlnFV3a3
 rY.10PicIC9R4kO9Q_6CHqhMe_HFHIxUxULlecSzovT5hoa0ClIrq7ROQAY3vcqMY969y9uPXT8H
 dy.foAYEM6ae4hfXKzup8714PbfMRqIYzE3N5XpGLG.8oQWC5856m9yuZcLVKgBgMDCKrXPWYiiu
 Vgr5Qup2JXYpyZQhMPTFn26VvRhxktmMNEzR5PMtkZpYeTdYvtQedcFd2QR7Zv1BlyrnOEn0BSq6
 MRX6PEN5R1azo3FpZ.VOQr03ywb9K83v9be9cCz6lQxOfPXqLvsmGr3TlRgU5D3jVp0Df9g0Uly0
 zm7HbO2olG5YNctSUOJijlVYBkhnZ3W708asmzjY6DoF1Njj5p8M63OowT774eI4Uy.lwCW6b8kP
 ilePjMtqdRD.eH1egPpRbs2Vmz3tlsMIw3mNInvlnXB2VxDm3K63ButfwqApkxaq9Ycz.bIV67bK
 psWjIr3ED_K.Iq_cL7qg8X0Dioj2iF7qZApF3pyFDY2sygVd7S6tGQgPbzB7.k8DIcYpq0ce4T8k
 B23AcmF_ih91Wf6f1hiij0LRm.154ulHSC6_Hw9.Rv07dIiNxgPYPDkP21rkRi6qI7ssVZKNjbPE
 V9awaBjQV7Nv8dHZOuQZhCISS43NX7iOOsY1VXGGteS.4j9zxy8HSBRuf3jJ2MQwpcin7_zh7oTv
 pbClQBW3fSL5aPyJjy.dpdvsLQAnP6kuUDHZjsdbjOj0C2RoecP7oVHY03VuadMQQYJzrmQk0pqK
 .Ag6prwDaJSvK.rElz4wGAUjz440o16r75vZ7rCpNLB4zlXzsOzk6RPAOKKBnJP9tlHdObGeX5bp
 2F9V6AGMP0SEKNxl9T6T7czbZwUCos1vxRIjw_z6fJgt8QHmkj_CczsaDqyJ6CVz9oUeQFvwSdrd
 RVt7m4A--
X-Sonic-MF: <rubenru09@aol.com>
X-Sonic-ID: a03b6caa-6be5-409d-b0fd-45343ee32d95
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.gq1.yahoo.com with HTTP; Fri, 18 Apr 2025 15:18:16 +0000
Received: by hermes--production-ir2-858bd4ff7b-rjtcv (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 8d9c4354726140fe64c22851ae4eda49;
          Fri, 18 Apr 2025 15:18:10 +0000 (UTC)
From: Ruben Wauters <rubenru09@aol.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Cc: Ruben Wauters <rubenru09@aol.com>,
	linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] staging: sm750fb: remove unused code/files
Date: Fri, 18 Apr 2025 16:17:46 +0100
Message-ID: <20250418151755.42624-1-rubenru09@aol.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250418151755.42624-1-rubenru09.ref@aol.com>

This patch series removes three unused files and their
associated headers. The code was not used in any other
files (other than themselves).

The TODO mentions that this was sample code, however given
it was never implemented into the driver, I have elected to
remove it entirely.

Ruben Wauters (4):
  staging: sm750fb: Remove ddk750_sii164
  staging: sm750fb: remove ddk750_dvi
  staging: sm750fb: remove ddk750_hwi2c
  staging: sm750fb: remove irrelevant TODO line

 drivers/staging/sm750fb/Makefile         |   3 +-
 drivers/staging/sm750fb/TODO             |   3 -
 drivers/staging/sm750fb/ddk750.h         |   3 -
 drivers/staging/sm750fb/ddk750_display.c |   1 -
 drivers/staging/sm750fb/ddk750_dvi.c     |  62 ----
 drivers/staging/sm750fb/ddk750_dvi.h     |  57 ----
 drivers/staging/sm750fb/ddk750_hwi2c.c   | 247 --------------
 drivers/staging/sm750fb/ddk750_hwi2c.h   |  12 -
 drivers/staging/sm750fb/ddk750_sii164.c  | 408 -----------------------
 drivers/staging/sm750fb/ddk750_sii164.h  | 174 ----------
 10 files changed, 1 insertion(+), 969 deletions(-)
 delete mode 100644 drivers/staging/sm750fb/ddk750_dvi.c
 delete mode 100644 drivers/staging/sm750fb/ddk750_dvi.h
 delete mode 100644 drivers/staging/sm750fb/ddk750_hwi2c.c
 delete mode 100644 drivers/staging/sm750fb/ddk750_hwi2c.h
 delete mode 100644 drivers/staging/sm750fb/ddk750_sii164.c
 delete mode 100644 drivers/staging/sm750fb/ddk750_sii164.h

-- 
2.48.1

