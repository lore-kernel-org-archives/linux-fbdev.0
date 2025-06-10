Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F1628CF4B;
	Tue, 10 Jun 2025 10:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749551739; cv=none; b=r2HwHZMXs49m2IJ+zX4yYrxgDeJFbiT6McTGOvhT0xCNBGSHXQlkUxBOBxQDZpjwBXESvGutyEqH7C7Zw+sdNCIUeBILBXBGxfW6PZFhnbKnt3TZTMZ2TKkK+6LL8/NMn5OB8f4sD3HsnohakcyeXAbPI/KcMq3/dtzQBW7AOfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749551739; c=relaxed/simple;
	bh=CeQswRSD0Fu1GJhqXwPWw0zljZsyENP/fzUc2E8+hKQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=AgOFoWJqgUXIjEHH9LukX8Cf9PZnR0HmNVdAdYQArN/9rmHYEasoCwlEHammaxWTd8AIiTw/uJyT0o6+JwHL8JE7jiAMNHrbXmWDUQKlqW8qN1PK7+sZqhkDiXCqN+hl1B0roXc8Jdec6bdfH7mGc0GYqQXM2mW9t/AUgR/9SNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Dhg/CsQ3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NBonXYMv; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Dhg/CsQ3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NBonXYMv"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C51A925400E7;
	Tue, 10 Jun 2025 06:35:36 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Tue, 10 Jun 2025 06:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749551736;
	 x=1749638136; bh=wJ6K1Bg2EKOzCl4JP7wnZYiAEnsPSxJW7yzlyL9SDrY=; b=
	Dhg/CsQ3lwukqyGwumJyoh8RAFfoAk74WSQ0txZSQsI4k4EkwceQnuR1O63lCr6B
	YbZQx8FpKQPneYLaBDLrq09snuKmE36a+/puRsIVucSFD9tTnxS2TzBITsiUXKmh
	UP7PoDqXdLv/SB2e0A+nDbxJOfJ9DO/MEvsxtRMofu4gtqGvvy/HGLuobSe8KBf1
	nbpqPiw0K08htNZqXhdL+8TbFDeWyedMnWnLutGtiqqzVv/w+fYVxPNF422UYdy2
	xUM0umTq4TAzrh3UnW0pGckyYqKfLgZZDCSj5ege/mF19Pgoyv4iBLDbIIMGdjPx
	ZvnZ+VksqzRJepU9jQlXVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749551736; x=
	1749638136; bh=wJ6K1Bg2EKOzCl4JP7wnZYiAEnsPSxJW7yzlyL9SDrY=; b=N
	BonXYMvvEst6qDS4cbOonC6/2Wl30tJbHNRUj6h9MDvKE/x7rgJ0cH2SUvHUgGlY
	xHKaour2RolblsDPAH4MhsVnvZ+NRuk7Nb/GQJd9V3oZrKLVccwWslKS9oNkLgVr
	ArcrDoSOeVf+bOQBvPrYt4zoIJXG9cO3Uagl4ZiKPJzbu1VCXijX3SLbuF7HNXgI
	fqQG7jvc/DM1zFBrnWXwfDZrmbmPhQkb4z0Vtw/YkBzhNejKHv2gq0qx04zhv0hA
	89p6xso/1PVh2/RxzUe5a8zPvl28IXsYh+8sEvQQcCtGLQvD+UXI5EYQjV6ZlH48
	emfpKMLfMKt86cLN+50wA==
X-ME-Sender: <xms:dwpIaBC5s0BdUMi9rIszRUs_uxU5IaVtsiYzeMsN0UTl9PrLE8fJkQ>
    <xme:dwpIaPhHgMcMhnfxavaaUPPI9qNXF24yudbt0Xub1myL25S8GcRnReUvDIDZ2rTCR
    qSbknmRYQxfDGAvTM0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddutdeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedu
    fedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhihigrnhguhhhimhgrnhduge
    esghhmrghilhdrtghomhdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdho
    rhhgpdhrtghpthhtoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnh
    gurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghp
    thhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpth
    htohepughrihdquggvvhgvlheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdhsthgrghhinhhgsehlihhsthhsrdhlihhnuhigrdguvg
    hvpdhrtghpthhtoheplhhorhgvnhiiohdrshhtohgrkhgvshesohhrrggtlhgvrdgtohhm
    pdhrtghpthhtohepjhgvfhhfrdhjohhhnhhsohhnsehoshhsrdhquhgrlhgtohhmmhdrtg
    homh
X-ME-Proxy: <xmx:dwpIaMnMR5IEeoAfV7RdRsbM__rzDqhhPYk6CToFFEJAkb4IFYsTTw>
    <xmx:dwpIaLwzviYxwPrNq2HPvQOCyhWI5vfYvN0QT43CZSeNvcZcaXcsJg>
    <xmx:dwpIaGSzClcDHloai92YpmPG90Iwig9HauMVZdWpwyQ22tZFT4_x7Q>
    <xmx:dwpIaObV0EV9TpgQ6ZwKz87VncvtDCPgnSZVjDT6mKV3LVU8fbnaNQ>
    <xmx:eApIaD1ewy-S6aw_2-p9Tr4q9kMUoeXujPaEiz3NhmiOsEgC11XQs8Ca>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 92CDE700061; Tue, 10 Jun 2025 06:35:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T57998a13661304d4
Date: Tue, 10 Jun 2025 12:35:14 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Riyan Dhiman" <riyandhiman14@gmail.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Paolo Perego" <pperego@suse.de>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>,
 "Matthew Wilcox" <willy@infradead.org>,
 "Jeff Johnson" <jeff.johnson@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Message-Id: <088dc0a1-fc54-478c-b253-4ed5dd6d6bae@app.fastmail.com>
In-Reply-To: <aEgIX221QIt5k0zY@smile.fi.intel.com>
References: <20250610092445.2640575-1-arnd@kernel.org>
 <aEgIX221QIt5k0zY@smile.fi.intel.com>
Subject: Re: [PATCH] fbtft: reduce stack usage
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Jun 10, 2025, at 12:26, Andy Shevchenko wrote:
> On Tue, Jun 10, 2025 at 11:24:38AM +0200, Arnd Bergmann wrote:
>> Move the varargs handling into a separate noinline function so each
>> individual function stays below the limit. A better approach might be to
>> replace the varargs function with one that takes an array of arguments,
>> but that would be a much larger rework of the other callers.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> ...

Thanks

>> +static noinline_for_stack void fbtft_write_register_64(struct fbtft_par *par,
>> +							int i, int buf[64])
>
> Perhaps int i, int buf[64] should be u32?

Right, I can send an updated patch, or this could be fixed up when applying
the patch

>> +{
>> +	par->fbtftops.write_register(par, i,
>> +		buf[0], buf[1], buf[2], buf[3],
>> +		buf[4], buf[5], buf[6], buf[7],
>> +		buf[8], buf[9], buf[10], buf[11],
>> +		buf[12], buf[13], buf[14], buf[15],
>> +		buf[16], buf[17], buf[18], buf[19],
>> +		buf[20], buf[21], buf[22], buf[23],
>> +		buf[24], buf[25], buf[26], buf[27],
>> +		buf[28], buf[29], buf[30], buf[31],
>> +		buf[32], buf[33], buf[34], buf[35],
>> +		buf[36], buf[37], buf[38], buf[39],
>> +		buf[40], buf[41], buf[42], buf[43],
>> +		buf[44], buf[45], buf[46], buf[47],
>> +		buf[48], buf[49], buf[50], buf[51],
>> +		buf[52], buf[53], buf[54], buf[55],
>> +		buf[56], buf[57], buf[58], buf[59],
>> +		buf[60], buf[61], buf[62], buf[63]);
>> +}
>
> Wondering if we may reuse this in other cases (by providing the additional
> length parameter). But it may be done later on.

I tried this and that quickly became a mess. It is probably a good
idea to rework the code to completely avoid the varargs function
pointer and instead take an array here, but this is not something
I could easily do myself as that takes more time and needs better
testing.

       Arnd
