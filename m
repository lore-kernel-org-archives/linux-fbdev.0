Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575087;
	b=Ncvn+xmf72PQBRzd27+FzZrW4l8pjx7cEkBGAAcU7xxYcDBA/hdLFLpUNcG23HqoiMw5
	 or32fzByrnTOlcvSvT5Mni8AweGZhCCusLT3zoj9G9lXEc3Ivjy1piTZBBvHzPyXz+uNr
	 hnLnlgDPfNRV3VpndhSdnePNp7ottBO5SH6pgXrYNyTMNAkxiNCxJ7vfVTXGX8JieFEnQ
	 CFXlB7JSrkmFHCPXFjV5SdfkkKRDvE4QWt1f911OaLE6rL2rRbtTu2ORQb8C0AT3k3VoK
	 4dNgYtS6J6mvzEgzObyOWgofkQl5TduYAErXhdXqtv4XmToeDXurYSeYuycUA+EdY7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575087;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id:X-Mailer:X-Last-TLS-Session-Version;
	bh=uJDbNGEvEPuyHEi4/1DJ4jhZX8PG8UyJOf76Gs/epng=;
	b=SiccfiFAYnzfW0RJ4nHhRJqtEBbx7i+AAnI2DCt2Mi0kVjxIjg7SDvpVtE4ZQt7Ovi0H
	 ecjb2++nkHXmA5qevP4HYvHSrOOyJVbs2W6n+h56d0vnIuvvzPY4tueuztWk5N4+Y2yvB
	 WEqAhrSkQxVPPfj3CslbYvbk9jCiui/OSwkvqwinCVi3Ibv3ZsrsSgWJPJftla7F6ovXm
	 fkZkhVUkHM7YfKAUafG7dfSqX/uNCzbLMWmky5A7RyWxIhyO6WJmvw0pg30mVB4YjjrPQ
	 /5UbUwfT3ah5fgsphXvWo09R4gtXq0U2qQGO6LHf+Va1aGk0K8+5d+EAV3VNN0SKo3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Au6AAUsk;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B950F606A333;
	Fri, 13 Nov 2026 13:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B950F606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Au6AAUsk
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2D86C1A1652;
	Fri, 13 Nov 2026 13:04:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 01C1A60015;
	Fri, 13 Nov 2026 13:04:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ED23311BC1A33;
	Fri, 13 Nov 2026 14:04:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794575083; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=uJDbNGEvEPuyHEi4/1DJ4jhZX8PG8UyJOf76Gs/epng=;
	b=Au6AAUskR9cowvdwGlEfrmhMnCt3P9UapTjafWmwdm1QpBOrVKpCMwsfv3q7uIP0yRFZo2
	euCBuAXz2rdO2FIBC/0c2hdW2N0aM2KiOLZpPf1NOnijSBRcBU7sYhliQebZ+frKKJIbfG
	11tICCqCuVeSXc7tfyqj7kyZaec15uqcT9MI74IknpXlMk8IL4ZwX0gzIEXZc47yabiGea
	tB/Hge3JH2pZJlY04e02pgIXXQKMMxNU9qlsOmKP8AvbEAzY7gtkbWf0ObaV+VY4Kqektn
	6eOAmxRXR3lT68D7x5BC573JePOLLSu1TyllnG8bvjm6Uq/Db5IQkRUp+P7bLQ==
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] backlight: cgbc_bl: Fix kernel-doc
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: Thomas Richard <thomas.richard@bootlin.com>, Lee Jones <lee@kernel.org>, 
 Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
 Helge Deller <deller@gmx.de>, Petri Karhula <petri.karhula@novatron.fi>, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261113114552.895592-2-manuelebnerli@mailbox.org>
References: <20261113114552.895592-2-manuelebnerli@mailbox.org>
Date: Fri, 13 Nov 2026 14:04:24 +0100
Message-Id: <179457506498.2156325.15213734004250647816.b4-review@b4>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

On Fri, 13 Nov 2026 12:45:52 +0100, Manuel Ebner <manuelebnerli@mailbox.org> wrote:
> This comment describes a struct as a kernel-doc. Format as such, fixing:
>   $ ./scripts/kernel-doc --none drivers/video/backlight/cgbc_bl.c
>   Warning: drivers/video/backlight/cgbc_bl.c:29 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
>    * CGBC backlight driver data

Reviewed-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>

-- 
Best Regards,
Thomas Richard

