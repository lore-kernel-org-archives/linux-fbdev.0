Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715044654B;
	Wed, 15 May 2024 07:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715759282; cv=none; b=gVIPPqg1CfCdnvQbmgIwy85FbP8O+/L+ZW0e96din9C8voCTdxDtNU+oHiH4Vmvp7ENSI61LRxbojPmxIkZVrrRHryxc/rcrEzgA59m+fiCtGk2XkoyN6T5Qk6e1/yPKdFKITbCBeXND3KQwyqo+dv8U5IU9dZjSmdpUw59eFXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715759282; c=relaxed/simple;
	bh=7+Rm9slZp7s5VN1EMhP2yf5x2G6kbVKBXKCd/UkqlM4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=drn95A386rNqn5z8PtizDwd4podQXwJu+jTjnuzFm4JUAXSSsisSMMLdPivhPPNIuLzpPId4A1eEt1LFeGaDRIURpkPhPMYoSknyUNk1PsLDfFuf/6qr6nkZ9eiCesOwn/P+K3dl8UVYS7eReYTwn1dNubnCTEhrfwW8XXN5Ma0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asAaV+Xi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asAaV+Xi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AC8C116B1;
	Wed, 15 May 2024 07:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715759282;
	bh=7+Rm9slZp7s5VN1EMhP2yf5x2G6kbVKBXKCd/UkqlM4=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=asAaV+XiTWpRtr/53VyBjtRKjT70kq+L57IcLebru/ozd3/6tDpF6QLNbFPW7K3gM
	 DLpKBBqKI0O+sufJdOtbAsJ79wlfNcv+Uc85KJshD2+qlnc5P9nbF0fgvSryWNg0Xi
	 btBfa70afOK1PwrvyQI7UFTJ17CDJVORqPorkDJjvUePg1GJd5CmRSjoInpidgUC7G
	 ZLoc/RftJhQIem0HTsVoudNijaBN9b1YbeOi04GNbz+j6cjnXxShprq8PMFYgTC6MF
	 iHXBAGkT3ttK1Lndkeyh/TBn6r+SFVTNmfuzAVvKa3DkeIxKv+pfXn348yo/PRO+vf
	 ZjHsWCB6Fjf3Q==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id C57E31200032;
	Wed, 15 May 2024 03:48:00 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 15 May 2024 03:48:00 -0400
X-ME-Sender: <xms:sGhEZjZ2gZSgOcEaEixOE7W1VlXD32ttp_zgD9gGIu0vkBDFwlJosA>
    <xme:sGhEZib1EaFq3rct_1jI7x4lIiwh-zePANKVB6_BYz5OlbMpPKpegcbpzEtaEGMbm
    B7vVETCbx-FnzxUR8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedvveeigfetudegveeiledvgfevuedvgfetgeefieeijeejffeggeeh
    udegtdevheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrrhhnugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidquddvkeehudej
    tddvgedqvdekjedttddvieegqdgrrhhnugeppehkvghrnhgvlhdrohhrghesrghrnhgusg
    druggv
X-ME-Proxy: <xmx:sGhEZl_dTaFyJaVAMtSf8UIwFESqX5NZ9AAANd-fTDlNx4CRewDQSw>
    <xmx:sGhEZpoHgl15LrdhdbtCus11HSKbDai1YZx8fWoOWJ9yr5GNWj8H4A>
    <xmx:sGhEZupcbW2ri4W-vtO-Qw0-MNjYTOCyScod6gjFQAXagUoNOt4Tww>
    <xmx:sGhEZvRnqe0zoluW3buZV1Oc4pdjdwCIgc5-HcHuKpKHSHEGMM1GxQ>
    <xmx:sGhEZmoMFEQooAYaKtCnJaCuJiEJ31sG8oiq-XvEc8qi-O1GV450kt5w>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 89646B6008F; Wed, 15 May 2024 03:48:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-455-g0aad06e44-fm-20240509.001-g0aad06e4
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5c992610-0716-47d1-97f6-65901797aa8c@app.fastmail.com>
In-Reply-To: <20240514130858.3048650-2-schnelle@linux.ibm.com>
References: <20240514130858.3048650-1-schnelle@linux.ibm.com>
 <20240514130858.3048650-2-schnelle@linux.ibm.com>
Date: Wed, 15 May 2024 07:47:29 +0000
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Niklas Schnelle" <schnelle@linux.ibm.com>, "Helge Deller" <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 "Heiko Carstens" <hca@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] video: Handle HAS_IOPORT dependencies
Content-Type: text/plain

On Tue, May 14, 2024, at 13:08, Niklas Schnelle wrote:
> In a future patch HAS_IOPORT=n will disable inb()/outb() and friends at
> compile time. We thus need to #ifdef functions and their callsites which
> unconditionally use these I/O accessors. In the include/video/vga.h
> these are conveniently all those functions with the vga_io_* prefix.
>
> Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
> Note: This patch does not depend any not-yet-mainline HAS_IOPORT changes
> and may be merged via subsystem specific trees at your earliest
> convenience.
>
> v1 -> v2:
> - Moved vga_mm_r(), vga_mm_w(), vga_mm_w_fast() above #ifdef CONFIG_HAS_IOPORT
>   to use them in with or without I/O port variants.
> - Duplicated vga_r(), vga_w(), vga_w_fast() functions as non-I/O port variants
>   to get rid of in-code #ifdef (Arnd)
> - Got rid of if (regbase) logic inversion needed for in-code #ifdef

Thanks for preparing the new version!

> diff --git a/include/video/vga.h b/include/video/vga.h
> index 947c0abd04ef..468764d6727a 100644
> --- a/include/video/vga.h
> +++ b/include/video/vga.h
> @@ -197,9 +197,26 @@ struct vgastate {
>  extern int save_vga(struct vgastate *state);
>  extern int restore_vga(struct vgastate *state);
> 
> +static inline unsigned char vga_mm_r (void __iomem *regbase, unsigned 
> short port)
> +{
> +	return readb (regbase + port);
> +}

My first thought was that this should use the normal whitespace,
but I guess the file is pretty consistent about the style here,
so I agree with your choice here.

      Arnd
