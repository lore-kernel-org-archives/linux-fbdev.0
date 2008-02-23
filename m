From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/1 2.6.24] fbdev: defio and
 Metronomefb v3
Date: Sat, 23 Feb 2008 00:07:05 -0800
Message-ID: <20080223000705.9c5eda0f.akpm@linux-foundation.org>
References: <20080218134125.5159.58386.sendpatchset@nxdomain.guide.opendns.com>
	<Pine.LNX.4.64.0802181502550.12244@anakin>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JSpRL-00086r-Oh for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 Feb 2008 00:08:59 -0800
Received: from smtp1.linux-foundation.org ([207.189.120.13])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JSpRK-0004x7-Dk
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 Feb 2008 00:08:59 -0800
In-Reply-To: <Pine.LNX.4.64.0802181502550.12244@anakin>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net, Jaya Kumar <jayakumar.lkml@gmail.com>

On Mon, 18 Feb 2008 15:03:08 +0100 (CET) Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Mon, 18 Feb 2008, Jaya Kumar wrote:
> > This patch implements support for the E-Ink Metronome controller. It
> > provides an mmapable interface to the controller using defio support.
> > 
> > I welcome your feedback. Please let me know if it looks okay to apply.
> 
> To me it looks OK.
> 

It doesn't to me - I think I found several issues.

Please, silence is preferable to a quick scan and a poor ack.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
