From: Sebastian Siewior <frame+buffer@ml.breakpoint.cc>
Subject: Re: [PATCH v3] [FB] Add the carmine FB driver.
Date: Mon, 21 Apr 2008 18:26:38 +0200
Message-ID: <20080421162638.GA17526@Chamillionaire.breakpoint.cc>
References: <20080421120706.GC11534@Chamillionaire.breakpoint.cc>
	<20080421143907.GA19553@mx.loc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jnyr1-0002Od-O4 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 21 Apr 2008 09:26:55 -0700
Received: from chamillionaire.breakpoint.cc ([85.10.199.196]
	ident=G2wL6ZuayTZo\z0haXx|IP)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Jnyqq-0003vC-1D
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 21 Apr 2008 09:26:45 -0700
Content-Disposition: inline
In-Reply-To: <20080421143907.GA19553@mx.loc>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Bernhard Fischer <rep.dot.nop@gmail.com>
Cc: tglx@linutronix.de, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, Antonino Daplas <adaplas@gmail.com>

* Bernhard Fischer | 2008-04-21 16:39:07 [+0200]:

>>+choice
>>+    depends on FB_CARMINE
>>+    prompt "DRAM timming"
>
>s/timming/timing/g
>
>>+	/* Set default curor position */
>
>s/curor/cursor/g
>
>>+static void set_display_parameters(struct carmine_fb *par)
>>+{
>>+	u32 mode;
>>+	u32 hdp, vdp, htp, hsp, hsw, vtr, vsp, vsw;
>>+
>>+	/*
>>+	 * display timing. Parameters ae decreased by one because hardware
>
>s/ae/are/
>
>s/ressolution/resolution/g

Thx for the feedback, going to fix this.

Sebastian

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
