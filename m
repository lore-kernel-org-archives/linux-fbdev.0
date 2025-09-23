Received: from sender4-g3-154.zohomail360.com (sender4-g3-154.zohomail360.com [136.143.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BBAC2E0
	for <linux-fbdev@vger.kernel.org>; Wed, 24 Sep 2025 00:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758674594; cv=pass; b=T9bFfsHtO9pZWJBHvgDnThqrGoiEFd/T3KE2Y/4EwWiZ5qDrl0l9nWrHDsH1GOyzaZxzplcjOQ7gl9GYviN61jV2XniEI3a8l/4SLqQG/6cRAUJSYb4/Vo59h5FlgltAEuoW2+raTYz00pQ76lks+ivULja46PGj1P0L5ZVFuDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758674594; c=relaxed/simple;
	bh=JGduRyMVPl3a62DBNI53x2FW/L4LP2OZh/Amhlzlr44=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=pLI18iGjQdRIZb+xQydQJSsPO55qJglfI32+v5A+QsRTKINp/qfjHG4Vpy7EMgzW0Yvgzp15ItRwes/UMrFKv7BTZGAWsd+CZtIx2nlxckRzvstO60+0LmDHbnwIF0M6O5w+jJKeOPAafwT5NLWqkLFDtiC1FFzQPcBWihgc/eQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx; dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b=eGytGII+; arc=pass smtp.client-ip=136.143.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b="eGytGII+"
ARC-Seal: i=1; a=rsa-sha256; t=1758674591; cv=none; 
	d=us.zohomail360.com; s=zohoarc; 
	b=fCLaCgKGn+M+ZnbVegAfrjnK8zaO16JkI6gHKAWvPBca9uVUv36+3Z6zOIeVBdiSKSThMn+3amIh+5yrugWs9+ToZph+bXaoARmMUX3yjls0gUZ9lahTwQ4cwcr01bYM8ZDwltM3xk3YEbyNp1SK5e9XiuymV1iudNWbc++x5b8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=us.zohomail360.com; s=zohoarc; 
	t=1758674591; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Reply-To:Reply-To:Subject:Subject:To:To:Message-Id:Cc; 
	bh=JGduRyMVPl3a62DBNI53x2FW/L4LP2OZh/Amhlzlr44=; 
	b=YjHlBPKfM0CwXuaAAe6F35pxo5LiEsl9Ufhq2eyyFKoGrPMlIXUvyO83cYOwK825Bam52STx2fzl5sIm1tOT2CemZ4rGDL6qj/hwTJDwXEFLyO9IIzmsFQDmtUOGyxBZaDCGjEjitH2/GYSMMABbTSyyxuCmNFueksgRqZVBzn4=
ARC-Authentication-Results: i=1; mx.us.zohomail360.com;
	dkim=pass  header.i=maguitec.com.mx;
	spf=pass  smtp.mailfrom=investorrelations+9a728640-98d8-11f0-ace3-525400721611_vt1@bounce-zem.maguitec.com.mx;
	dmarc=pass header.from=<investorrelations@maguitec.com.mx>
Received: by mx.zohomail.com with SMTPS id 1758671652858886.9275174803346;
	Tue, 23 Sep 2025 16:54:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; b=eGytGII+qalhjnLfv7i+kYG+HxL0UtB9ZwHyjBMz3DVs19cze8gyFLDk418kKjb74WoI6Njce5Y7DXrVI0VEN/lC2pDL0nN1xnj6DQ6nYk5RXr2GeAeXw95i48INi93pom5atHZpGkBTIVHUVDf0G1BKOAcderPsnsO9gFiUVUY=; c=relaxed/relaxed; s=15205840; d=maguitec.com.mx; v=1; bh=JGduRyMVPl3a62DBNI53x2FW/L4LP2OZh/Amhlzlr44=; h=date:from:reply-to:to:message-id:subject:mime-version:content-type:content-transfer-encoding:date:from:reply-to:to:message-id:subject;
Date: Tue, 23 Sep 2025 16:54:12 -0700 (PDT)
From: Al Sayyid Sultan <investorrelations@maguitec.com.mx>
Reply-To: investorrelations@alhaitham-investment.ae
To: linux-fbdev@vger.kernel.org
Message-ID: <2d6f.1aedd99b146bc1ac.m1.9a728640-98d8-11f0-ace3-525400721611.19978ffc4a4@bounce-zem.maguitec.com.mx>
Subject: Thematic Funds Letter Of Intent
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
content-transfer-encoding-Orig: quoted-printable
content-type-Orig: text/plain;\r\n\tcharset="utf-8"
Original-Envelope-Id: 2d6f.1aedd99b146bc1ac.m1.9a728640-98d8-11f0-ace3-525400721611.19978ffc4a4
X-JID: 2d6f.1aedd99b146bc1ac.s1.9a728640-98d8-11f0-ace3-525400721611.19978ffc4a4
TM-MAIL-JID: 2d6f.1aedd99b146bc1ac.m1.9a728640-98d8-11f0-ace3-525400721611.19978ffc4a4
X-App-Message-ID: 2d6f.1aedd99b146bc1ac.m1.9a728640-98d8-11f0-ace3-525400721611.19978ffc4a4
X-Report-Abuse: <abuse+2d6f.1aedd99b146bc1ac.m1.9a728640-98d8-11f0-ace3-525400721611.19978ffc4a4@zeptomail.com>
X-ZohoMailClient: External

To: linux-fbdev@vger.kernel.org
Date: 24-09-2025
Thematic Funds Letter Of Intent

It's a pleasure to connect with you

Having been referred to your investment by my team, we would be=20
honored to review your available investment projects for onward=20
referral to my principal investors who can allocate capital for=20
the financing of it.

kindly advise at your convenience

Best Regards,

Respectfully,
Al Sayyid Sultan Yarub Al Busaidi
Director
