From: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: Generic VESA framebuffer driver and Video
	card BOOT?
Date: Sat, 16 Oct 2004 19:01:35 +1000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1097917295.4763.35.camel@desktop.cunninghams>
References: <416E6ADC.3007.294DF20D@localhost> <87d5zkqj8h.fsf@bytesex.org>
	 <Pine.GSO.4.61.0410151437050.10040@waterleaf.sonytel.be>
	 <20041015112902.A12631@unix-os.sc.intel.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CIkUn-0000sW-48
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 16 Oct 2004 02:05:01 -0700
Received: from pop5-1.us4.outblaze.com ([205.158.62.125])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CIkUk-0007hy-B1
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 16 Oct 2004 02:05:01 -0700
In-Reply-To: <20041015112902.A12631@unix-os.sc.intel.com>
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
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>, penguinppc-team@lists.penguinppc.org

Hi.

On Sat, 2004-10-16 at 04:29, Venkatesh Pallipadi wrote:
> > Why not? Of course you won't get any output before the graphics card has been
> > re-initialized to a sane and usable state...
> > 
> 
> True. I do it on my Dell 600m (Radeon 9000M) using usermodehelper and
> it works just fine. It works both with VGA and X. I need to split up
> the thaw_processes into two stages though. It may not work with fb as
> fb driver resumes earlier. I use the patch below for the kernel and a
> userlevel x86 emulator.
> 
> I have to say though, it will help if we have a such an emulator in the kernel.

Just a quick question: is this the right way to distinguish kernel
threads? I've been checking if the process has an mm context (if p->mm).

> +		if (p->parent->pid != 1)
> +			continue;

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
