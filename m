From: "Luiz Fernando N. Capitulino" <lcapitulino@prefeitura.sp.gov.br>
Subject: Re: [PATCH] - video/hgafb.c warning fix.
Date: Wed, 14 Apr 2004 14:30:53 -0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040414143053.2210fbe9.lcapitulino@prefeitura.sp.gov.br>
References: <20040413164534.17eb0c1b.lcapitulino@prefeitura.sp.gov.br>
	<20040414164801.GA2658@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BDoF2-0002Dg-59
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Apr 2004 10:32:04 -0700
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BDoF1-0007Se-OY
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 14 Apr 2004 10:32:03 -0700
In-Reply-To: <20040414164801.GA2658@dreamland.darkstar.lan>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: kronos@kronoz.cjb.net
Cc: jsimmons@infradead.org, benh@kernel.crashing.org, linux-fbdev-devel@lists.sourceforge.net

Em Wed, 14 Apr 2004 18:48:01 +0200
Kronos <kronos@kronoz.cjb.net> escreveu:

| Il Tue, Apr 13, 2004 at 04:45:34PM -0300, Luiz Fernando N. Capitulino ha scritto: 
| > 
| > Hi,
| > 
| >  I'm getting the fallowing warnings:
| > 
| > drivers/video/hgafb.c:452: warning: `hgafb_fillrect' defined but not used
| > drivers/video/hgafb.c:472: warning: `hgafb_copyarea' defined but not used
| > drivers/video/hgafb.c:502: warning: `hgafb_imageblit' defined but not used
| > 
| >  They are caused by dead code, this patch remove then:
| 
| Please don't do that. The functions that you are removing are
| accelerated helpers. Don't know why they are not in use ATM (lack of
| testing?) If you want to remove the warning wrap the code with #if 0 /
| #endif

 Ok, my first version to Andrew used #if 0 / #end, but as he said to send to
the mantainers, so I thought it could be removed.

 Will rediff.

 thanks,

-- 
Luiz Fernando N. Capitulino
<lcapitulino@prefeitura.sp.gov.br>
<http://www.telecentros.sp.gov.br>


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
