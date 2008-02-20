From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [PATCH 1/1 2.6.24] fbdev: defio and
	Metronomefb v3
Date: Wed, 20 Feb 2008 08:18:35 -0500
Message-ID: <45a44e480802200518s21aeb938pd2375de44fc00b31@mail.gmail.com>
References: <20080218134125.5159.58386.sendpatchset@nxdomain.guide.opendns.com>
	<Pine.LNX.4.64.0802181502550.12244@anakin>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JRoqM-0001tE-P2 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 Feb 2008 05:18:39 -0800
Received: from el-out-1112.google.com ([209.85.162.176])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JRoqL-0006RB-AC
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 Feb 2008 05:18:38 -0800
Received: by el-out-1112.google.com with SMTP id y26so1296299ele.18
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 20 Feb 2008 05:18:36 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0802181502550.12244@anakin>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: adaplas@pol.net, akpm@linux-foundation.org, linux-fbdev-devel@lists.sourceforge.net, sfr@canb.auug.org.au

On Mon, Feb 18, 2008 at 9:03 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Mon, 18 Feb 2008, Jaya Kumar wrote:
>  > This patch implements support for the E-Ink Metronome controller. It
>  > provides an mmapable interface to the controller using defio support.
>  >
>  > I welcome your feedback. Please let me know if it looks okay to apply.
>
>  To me it looks OK.
>

Thanks Geert.

I have a follow-up question on the next steps of getting this merged.
I saw Stephen Rothwell's announcement of a new tree called linux-next.
[ http://lwn.net/Articles/268881/ ] He also said:
"
  otoh, a lot of the -mm queue is _not_ cross-subsystem: fbdev, uml, various
  new drivers and features, etc.  So I'll need to split -mm into multiple
  queues and feed many of them into linux-next.
"
I have not understood this. Does this mean that this type of patch,
ie: a new fbdev driver, should aim towards merging into akpm's -mm
tree? or that there needs to be a fbdev subsystem git tree that
Stephen can pull from into linux-next?

Thanks,
jaya

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
