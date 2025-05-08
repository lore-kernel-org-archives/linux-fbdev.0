Received: from sonic316-15.consmr.mail.bf2.yahoo.com (sonic316-15.consmr.mail.bf2.yahoo.com [74.6.130.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0AA208D0
	for <linux-fbdev@vger.kernel.org>; Thu,  8 May 2025 01:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.6.130.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746666729; cv=none; b=X1HHJH4DpOoICO6Fh9YSfxI9Yvaz7UpqDpeIOdZ+izeie6a+iy7AmJGSg0fCOxCDREs23M+GAgl5dqC1iF3wW2qTRqdRDnXxrSwtGylKzolDk2wJz555i2v7+cHaGLuZ59o7IviDYfF8tF1NOx/sZbYV+Nur+2njxY/wQUwAoQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746666729; c=relaxed/simple;
	bh=fP6BAlHP5tvpr4Wj8kjHJMnXzSSJG1Lb1joP285QboA=;
	h=Date:From:Subject:To:Cc:Message-Id:MIME-Version:Content-Type:
	 References; b=YRBqtNNWfgchgo2m+06oaQIahPm+QYSS/4L9HWP+0XrCpUpPZh4oJcemJtqB+l+yW17bXvJ25ncMX95jVoG2tfsk7AEvrCMux/nOFyMeIx2qxZC5E/JVYj8nOgQtLl80ZF6gZU8God3BgoW7ACg8bt55mjF7iDkY9LuqAGrzjzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=att.net; spf=pass smtp.mailfrom=att.net; dkim=pass (1024-bit key) header.d=att.net header.i=@att.net header.b=TVGN4QWx; arc=none smtp.client-ip=74.6.130.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=att.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=att.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=att.net header.i=@att.net header.b="TVGN4QWx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1746666726; bh=K+NvpHuxTHCYc55RLyDKUbHz3mp4Nug12ySOF+JDeSg=; h=Date:From:Subject:To:Cc:References:From:Subject:Reply-To; b=TVGN4QWxPVGUb1vEymHZgskt6rwf5KZvcQBvo3+tDcFMEVv6iByDbGe/vkVNW0e+7xi6gyjDLq542wzHYTw7QdQS2XrwV2tXoMabBD7I5xpRZTlFW6on87xQ2YeVd5+7HdMB5ggjc1QwiQtt4CP9wa98+u+j+QSikrkSixO2KhQ=
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1746666726; bh=m0Ns6sIEdJ3LKda0I3Ukagzb6WDsnr3HcdlxrLiJJHd=; h=X-Sonic-MF:Date:From:Subject:To:From:Subject; b=CkriBk5jcaHJkCTD2kK9ZHpe6RXgDC2p9CqfmQ+0Z/wECHAydNFTkU99sHVBSTA3LFADi/aD1hdRY1TuB1mfUkHR4pVYaqbxenXPc2JnozkLBpTMcwyBuT+N/mmuY+6adzX/WeBBXeUslb2FlLphtrx19XQUDdgHo9Mrl9r2W9tjC2Vaad3nb8496vLf42ainpeJ+VR5itTN6l7tAROpejwHleN1RvQwCUhOYToIGUBqUZJuLC9MEY9CQ7gFAbMHPIJcyroMwDJMOPGD/NGtq9MI29BRhFW5ZVOmrUHRemEgzErNhQjoy9aQSigDTKdAtW/v4cxNZcVpUmI8WZaT7Q==
X-YMail-OSG: EdSpAG0VM1m2mEiGcLHujbsmagrjKRuouMSZ2EYuVY8FeW.qThcVWBqeYBGAKvp
 teD0BR1rX0Vaaoswakh9dToQIyvihMFpLUnQQt3HGCYPWw9sZaiy4EIzubMuWJMAmJ6HzMVu_Jpc
 BaxzTeeru2c0NyReXGyjzsClBnEkhbvlh2HfVEzbtpYY_WIyH.pcx5Y8wk4UtNfI8O9pTf5ZQTOX
 as9AwjNX0f_d4bhyNGb7ot30uGuM295eMWh15_L0.eh.7IL3nCkjMHZ5EVlmkCeXmJupDLhvEHQH
 EleobIHfufxuGrksiayyjRQ3kLl90vUSd2edj3X9sSTDt_g5IJjHWELqUGErF4uYz4h7kzKH9TOS
 Ju9PWtQOZpwiL5leqXMXQPErHewqRMvJhvLJsxuH11nwS_1pJoReIkp7YS8SEqHUA8Vcn9kJ3aoZ
 a37Kf_UYlgyP2ON6oRSBUXxaZHt3T30of1l.bf2gzDFYIDgGBmhaUbJ0lvKSO1P1n9Z0b2Qhr5lO
 RoNr5xsT9cyUgvdYOMc_ibRWEv.kxEj66V2tpd0CCkewLyVdVyPc1qCr03yhdykdIYHDXYBguviA
 UMbvY10VQKYuGvulYsMFicfLgQHbPBtI5CspZ8gjx9T4BoGEMShp8c3ESdHpP4UD1jKF3k17v2bF
 jGfGQQUfYJpLrdVoXcqYhvnsACjCvMjRPXy5knK7DKe1AOHexfHSzFRIajp40HjdMn1vKB3rsIZH
 TSj23pWxlhLvOB0d7E0vpXHPy5eNIH0alZlTn3oIHtKQkLZAb90Jo_YxQ5e7BP4xX4jcS68zVfGM
 _rbUBMfF6ghsVPHKgWGzHYvfwNpCB_8CtBCdkX9E0K5kNfovKv59joZEP8PLe2ZJbbk_vynb48ak
 5c3oC9zABiQfAV4gA32bbD6avLiqmF_jTvpuvjaSMVoxq2mefZqT82GRCtxi.SgCzSrihI1_0lws
 kmYoltox8Df3tFrz7ttlvBPnsR.rOi9_t3vQnMFwiaRoXh7K1ObiJIRqq6dsy6HeRppzeZ5w5ge3
 UFQYpTnkWa0YaxkBaRaJwo6CHJx_qfrphgxSv36IgKYaRSFYFHBBElUyd.stH5oFAQjQFQSUBTr0
 OVfC0cf.YOV6lneH5aValJ_4kFg38tTkrR3U1pCJkOMMObLjfvyu3q.qtbpYxxvC5ONU97v.nvVC
 rUO.zPWzDdEUJsdKRTkvW_wQ1pTP8sdKkILWewKNwAE6hu96fjlfgxiT8EQbdz8JNXYutHgQxU6w
 CRXKGqhm09LsTfzdqOIFbCwfIPw91jXHGsegfz6EQj3K43JOGcRsgYV39wClnMlHdMBr5oZIW5su
 uRgvKwqU4vM_l4zbiY8gF_6jDpbGBoYIQXd9NTKUNzGSVEZIlkduQhgPEqFkdvX8V4f_5TH35buE
 LvjG8Zwgh363nYPh616VPFwxFXVopvyRciLiP.mXHXuD0fXc2wi8U2mP4Z17GCQUorF.dStDHGHv
 DgKU0svwp6PO3H008ydciJuvNKN3rlz_kM4Irp4l58PiPeQZjJR4GY5q5XFNq7iwNbBXCCTLrwTD
 .b3ZFQptWVDWWSD2LWCqZzoj2wXtyXmfw3xaArpbru14cPIKkY3V5lH7mHfB0rhXUtq8_fx4gzTk
 9pIlgnfFmVndJoxaM_KhfqN_Nq0yvw_V_D11M.IGgfuXbykAL6m.Dyj7C6Ea0q7OHgJn7cRuxXxo
 jndBOdR8nTN9KROaaklZUgIXRhwEH6r60dV7bqxBJEN0w5m1WfxPN6MmkQqkHu0432v6rv_.60wT
 an.BwRUUIjedioxOwhpW9SEhtjQuzxJFwcv3a0zs9kDIEQrCVm.SkGMNBUgxhtnsI5xKW4FsTxqf
 D7QPADWBQRB7Veh16O0BEU9SV0Y2bO.ingANb0ahJNJcAftApY8hxFEm37qo8fxarm5ZoTF0ZFnz
 wcIK0Ohnp3weoBTfozJ9kUSu9lxHxG7fqOA_o0hy2I2LZFgjoW8Gz_pyzKeHCOSVzyIIlaaXC.rT
 PmLS1D4zCnP3k.dnrL7vUFzteaQTNHWCbvvLzWqGcGf6wqgK8HyNJO10dk97rfEzICazuKAfUDRv
 7a4Ya5h2f4pnjC3ZXOqV5000fo3tOAk7CfIPqtUPfDN0.idWb4Xenwk_lp8lRCG9DbgCLACdM6oV
 Gk4JrPE5tugZ1oolIgPNKgL9ZUNvEkPq7jk6LqcVEvg.snH373T3oBFbsWZe1RR_ywb5I.eS_mK2
 nPRap3tjqFq2c6n5nmhwWwbtr1JZGp.fOTYwT8vMFHj1h
X-Sonic-MF: <pheonix.sja@att.net>
X-Sonic-ID: ec931b26-8e6d-42a1-8e0e-3593021713bb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Thu, 8 May 2025 01:12:06 +0000
Received: by hermes--production-ne1-9495dc4d7-7dn6v (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID bc54dd9b90d0255bc63680e5e0760f78;
          Thu, 08 May 2025 00:31:31 +0000 (UTC)
Date: Wed, 07 May 2025 20:31:24 -0400
From: Steven J Abner <pheonix.sja@att.net>
Subject: Re: Kernels >= 6.3 disable video output
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, pheonix.sja@att.net
Message-Id: <CS2XVS.S2O4K4ZU50ZS1@att.net>
X-Mailer: geary/40.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
References: <CS2XVS.S2O4K4ZU50ZS1.ref@att.net>

 > Kernels 6.2 and 6.3 are around 2 years old. Nobody will invest time 
there.

Sorry I guess I phased incorrectly. 6.2.16 is the last working kernel. 
It's mentioned because 6.3 is breaking code. This applies to all code 
after and including 6.3. My current build or home OS is 6.1.137 since 
it's long term and working. Orginal build was 6.13.4, Failed kernel 
from both build and Mainline of a Debian/Ubuntu based OS distribution 
of 6.8. Failed build of 6.6.89. Kernels I know to work are 5.4 thru 
6.2.16. Kinda did a bsearch type build to zero in on breaking kernel. 
It was the place I know factually that needs code regressed to fix all 
kernels >= 6.3. It could be fb related, I forget my test results based 
off of original 6.13.4. If I recall, both with and without firmware 
produced igpu shut off, yet kernel will run to full console use. Don't 
quote me on that :)
Steve


