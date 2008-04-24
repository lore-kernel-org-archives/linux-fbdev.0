From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [PATCH] [FB] metronomefb: don't free
	firmware twice in error path.
Date: Thu, 24 Apr 2008 09:57:56 +0800
Message-ID: <45a44e480804231857m430a05a4mf33f2fe23e6d4495@mail.gmail.com>
References: <20080421120931.GD11534@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Joqik-00023a-2E for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 23 Apr 2008 18:57:58 -0700
Received: from wf-out-1314.google.com ([209.85.200.173])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Joqii-0003am-TY
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 23 Apr 2008 18:57:58 -0700
Received: by wf-out-1314.google.com with SMTP id 28so2257131wff.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 23 Apr 2008 18:57:56 -0700 (PDT)
In-Reply-To: <20080421120931.GD11534@Chamillionaire.breakpoint.cc>
Content-Disposition: inline
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
To: Sebastian Siewior <frame+buffer@ml.breakpoint.cc>
Cc: linux-fbdev-devel@lists.sourceforge.net, Antonino Daplas <adaplas@gmail.com>

On Mon, Apr 21, 2008 at 8:09 PM, Sebastian Siewior
<frame+buffer@ml.breakpoint.cc> wrote:
> Right now, if request_irq or anthing after it fails than we free the
>  firmware for the second time what migh end bad :)

Agreed.

Acked-by: Jaya Kumar <jayakumar.lkml@gmail.com>

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
