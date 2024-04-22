Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6CA155328
	for <linux-fbdev@vger.kernel.org>; Mon, 22 Apr 2024 19:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713814161; cv=none; b=mWjwt6z8jXOQpgWi5ec3tJ1T4pEvExizDOhrPgPZ6YVEW6lYOQWo21vuRUi62deptgoTiLle3oyVszViExBOFJKCBuyZio9c/vsnl/PaEqDXY3x3gZ0N93SfKV6bNVgzlqZk+FCSksZo/wkccF796PA2VRK20cLUXgsw8eLvAng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713814161; c=relaxed/simple;
	bh=Sl3bg4WlJGYpNQQ2XrWaH54qrlh04DWMOhfUk4PpecA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=JEJsuiQnvj8p2CsZFaMQlpJgesQLw4bxiXh2rXxYi/pRtw41tbvIdOQS7egN9xMTDBp9QKom3hZo4H+n44OszNwx4OIHcy0QyR4wPtirg0JqiN3ROdrioRuMoMLiknS/okDXFgoGm4YcesoaXiIgj9OPQejqgbSM+9A5s7qKsLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uufkU32l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uufkU32l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8694EC4AF07;
	Mon, 22 Apr 2024 19:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713814161;
	bh=Sl3bg4WlJGYpNQQ2XrWaH54qrlh04DWMOhfUk4PpecA=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=uufkU32lzLrSCIFH39eg5bL0sBEX4btzkYstwIw3Po4n5lORy/Zy4G/SKX8+VDDzc
	 AZW8YTOORvr4D1V5NTd0wzX0yuISECS1JGYpSguukh7VCBPBWYhw37XJowS/ubGO4U
	 1ugZTzpE2CqlR8OW4oJqt10v7DjNGYanTwBHTA46cuyYuhjyt4k9FET21paVXngWFB
	 StWS+5PJcPuZ/w2lRXZTN6Q9QNj9sQTX4sqVxlG1MKq+74qtSllAh43lq+EKydXAGU
	 34RSIQb4FaAq9k0FVtxG/VGCraYIQwMlOFN8G1Pww7ykG726Zlc/bUlCJvlfHYczH/
	 nRcnC6lZluyHw==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 7EF181200066;
	Mon, 22 Apr 2024 15:29:19 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 22 Apr 2024 15:29:19 -0400
X-ME-Sender: <xms:j7omZhjlP81AZHYOK7fB-YL4puJb2jcvH7SRTVbSUlPZViGspNXMyQ>
    <xme:j7omZmA3HhaaFT3AokDixKUozs2VMXaNQVEhb0keRZ59x9q15dIbSFNYJGTevw89j
    PKe3FtnS1aBQ-vk7do>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekledgudeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedvveeigfetudegveeiledvgfevuedvgfetgeefieeijeejffeggeeh
    udegtdevheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrrhhnugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidquddvkeehudej
    tddvgedqvdekjedttddvieegqdgrrhhnugeppehkvghrnhgvlhdrohhrghesrghrnhgusg
    druggv
X-ME-Proxy: <xmx:j7omZhEsftRQyr4t7KGM57W5nx9vhCHXsNRcnzCuXPLc-kt3W7W27A>
    <xmx:j7omZmR133dXUwOEhLDCN4ECAkYyDyP98bWp4qj3nw9lQTKuzOv-vg>
    <xmx:j7omZuyXEPq5fKcU6bu36b_MeUgMUNRHoCkhyDQ97KFDPRP4jCYQtg>
    <xmx:j7omZs5TBZh7F08mE_vcVF4LJKrMba23xrU7LeHj5TsCR5tggSUqfA>
    <xmx:j7omZjxUFdxBz5hzgZ3VciArKk1jsZrREZlmc6rgvwh78sWWeaLLzBHp>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 3515AB6008D; Mon, 22 Apr 2024 15:29:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-386-g4cb8e397f9-fm-20240415.001-g4cb8e397
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a666e39d-a894-4e27-aac4-65d11a18358a@app.fastmail.com>
In-Reply-To: <26c23fb8557d806c12a246caa575e4f4fc4ea27a.camel@linux.ibm.com>
References: <20240410142329.3567824-1-schnelle@linux.ibm.com>
 <20240410142329.3567824-2-schnelle@linux.ibm.com> <Zhfs8CN5XdgldKUn@carbonx1>
 <26c23fb8557d806c12a246caa575e4f4fc4ea27a.camel@linux.ibm.com>
Date: Mon, 22 Apr 2024 21:28:58 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Helge Deller" <deller@kernel.org>
Cc: "Helge Deller" <deller@gmx.de>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "Heiko Carstens" <hca@linux.ibm.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] video: Handle HAS_IOPORT dependencies
Content-Type: text/plain

On Mon, Apr 22, 2024, at 10:34, Niklas Schnelle wrote:
> On Thu, 2024-04-11 at 16:00 +0200, Helge Deller wrote:
>> * Niklas Schnelle <schnelle@linux.ibm.com>:
>> > In a future patch HAS_IOPORT=n will disable inb()/outb() and friends at
>> > compile time. We thus need to #ifdef functions and their callsites which
>> > unconditionally use these I/O accessors. In the include/video/vga.h
>> > these are conveniently all those functions with the vga_io_* prefix.
>> 
>> Why don't you code it like in the patch below?
>> inb_p(), outb_p() and outw() would then need to be defined externally
>> without an implementation so that they would generate link time errors
>> (instead of compile time errors).
>
> This may be personal preference but I feel like link time errors would
> be very late to catch a configuration that can't work. Also this would
> bypass the __compiletime_error("inb()) requires CONFIG_HAS_IOPORT");
> added instead of the in*()/out*() helpers to make it easy to spot the
> problem.
>
> I'm not a fan of #ifdeffery either but I think in this case it is
> simple, well enough contained and overall there aren't that many spots
> where we need to exclude just some sections of code vs entire drivers
> with vga.h probably being the worst of them all.

Agreed. I also tried to see if we can move stuff out of vga.h
to have it included in fewer places, as almost everything that
uses this header already has a HAS_IOPORT dependency, but that
would be a lot more work.

The other one that gains a few ugly #ifdefs is the 8250 driver,
everything else is already merged in linux-next or needs a simple
Kconfig dependency.

I think we can make the vga.h file a little more readable
by duplicating the functions and still keep the __compiletime_error()
version in asm/io.h, see below.

    Arnd


diff --git a/include/video/vga.h b/include/video/vga.h
index 947c0abd04ef..7e1d8252b732 100644
--- a/include/video/vga.h
+++ b/include/video/vga.h
@@ -197,6 +197,23 @@ struct vgastate {
 extern int save_vga(struct vgastate *state);
 extern int restore_vga(struct vgastate *state);
 
+static inline unsigned char vga_mm_r (void __iomem *regbase, unsigned short port)
+{
+	return readb (regbase + port);
+}
+
+static inline void vga_mm_w (void __iomem *regbase, unsigned short port, unsigned char val)
+{
+	writeb (val, regbase + port);
+}
+
+static inline void vga_mm_w_fast (void __iomem *regbase, unsigned short port,
+				  unsigned char reg, unsigned char val)
+{
+	writew (VGA_OUT16VAL (val, reg), regbase + port);
+}
+
+#ifdef CONFIG_HAS_IOPORT
 /*
  * generic VGA port read/write
  */
@@ -217,22 +234,6 @@ static inline void vga_io_w_fast (unsigned short port, unsigned char reg,
 	outw(VGA_OUT16VAL (val, reg), port);
 }
 
-static inline unsigned char vga_mm_r (void __iomem *regbase, unsigned short port)
-{
-	return readb (regbase + port);
-}
-
-static inline void vga_mm_w (void __iomem *regbase, unsigned short port, unsigned char val)
-{
-	writeb (val, regbase + port);
-}
-
-static inline void vga_mm_w_fast (void __iomem *regbase, unsigned short port,
-				  unsigned char reg, unsigned char val)
-{
-	writew (VGA_OUT16VAL (val, reg), regbase + port);
-}
-
 static inline unsigned char vga_r (void __iomem *regbase, unsigned short port)
 {
 	if (regbase)
@@ -258,7 +259,25 @@ static inline void vga_w_fast (void __iomem *regbase, unsigned short port,
 	else
 		vga_io_w_fast (port, reg, val);
 }
+#else
 
+static inline unsigned char vga_r (void __iomem *regbase, unsigned short port)
+{
+	return vga_mm_r(regbase, port);
+}
+
+static inline void vga_w(void __iomem *regbase, unsigned short port, unsigned char val)
+{
+	vga_mm_w (regbase, port, val);
+}
+
+static inline void vga_w_fast (void __iomem *regbase, unsigned short port,
+			       unsigned char reg, unsigned char val)
+{
+	vga_mm_w_fast(regbase, port, reg, val);
+}
+
+#endif
 
 /*
  * VGA CRTC register read/write
