From: Sven Luther <luther@dpt-info.u-strasbg.fr>
Subject: Re: Radeon 9000 on a linux 2.4.18 kernel.
Date: Mon, 10 Feb 2003 17:59:33 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030210165933.GA692@iliana>
References: <20030124090423.GA1690@iliana> <Pine.BSF.4.50.0301241108120.74886-100000@shell.unixbox.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25] helo=mel-rto6.wanadoo.fr)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18iHHb-0002g7-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 10 Feb 2003 08:59:52 -0800
Content-Disposition: inline
In-Reply-To: <Pine.BSF.4.50.0301241108120.74886-100000@shell.unixbox.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ani Joshi <ajoshi@unixbox.com>
Cc: Sven Luther <luther@dpt-info.u-strasbg.fr>, linux-fbdev-devel@lists.sourceforge.net

On Fri, Jan 24, 2003 at 11:09:46AM -0800, Ani Joshi wrote:
> 
> Try patching your 2.4.18 with
> 
> http://gate.crashing.org/~ajoshi/radeonfb-0.1.6.diff.gz
> 
> (I forget which kernel I made this diff against, but it shouldn't complain
> much.)

It is a diff against 2.4.20, but i managed to apply the needed changes
from 2.4.18->2.4.19->2.4.20, so it didn't complain much. Still, there
were some stuff missing, but i think i got it right.

Anyway i built the kernel and launched it, it now recognize my radeon
9000, but my DVI connected monitor complains about wrong timings (it say
18,5KHz & 23Hz, which is not supported by the monitor). Anyway, here is
the relevant output :

radeonfb: ref_clk=2700, ref_div=12, xclk=25000 defaults
radeonfb: detected DFP panel size from registers: 1024x768
Console: switching to colour frame buffer device 80x30
radeonfb: ATI Radeon 9000 If DDR SGRAM 64 MB
radeonfb: DVI port DFP monitor connected
radeonfb: CRT port no monitor connected

Tell me if another part of the log is needed.

I will try connecting a analog monitor and see what happens.

Friendly,

Sven Luther


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
