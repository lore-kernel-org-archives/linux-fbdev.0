From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.26-rc9 1/5] pxafb: add shared
	framebuffer interface
Date: Sun, 20 Jul 2008 20:38:26 -0700
Message-ID: <45a44e480807202038v29dd0a57ld46c3c882a56195d@mail.gmail.com>
References: <1215955587-20367-1-git-send-email-jayakumar.lkml@gmail.com>
	<1215955587-20367-2-git-send-email-jayakumar.lkml@gmail.com>
	<f17812d70807160000y4fb9e543gdd25d6b6937af81e@mail.gmail.com>
	<45a44e480807160159j62b9f989l2ae99bd94d24a95f@mail.gmail.com>
	<20080716093855.GC23468@flint.arm.linux.org.uk>
	<45a44e480807160418g10090321uc57c338987d74b30@mail.gmail.com>
	<45a44e480807191941pb05934ay33c519c586572861@mail.gmail.com>
	<f17812d70807201910i7936268dp30b704fb6465e5bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KKmEI-0006OB-3u for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 20 Jul 2008 20:38:30 -0700
Received: from ik-out-1112.google.com ([66.249.90.183])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KKmEG-00078r-HB
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 20 Jul 2008 20:38:30 -0700
Received: by ik-out-1112.google.com with SMTP id c21so790221ika.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 20 Jul 2008 20:38:26 -0700 (PDT)
In-Reply-To: <f17812d70807201910i7936268dp30b704fb6465e5bd@mail.gmail.com>
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
To: eric miao <eric.y.miao@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, ymiao3@marvell.com, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk

On Sun, Jul 20, 2008 at 7:10 PM, eric miao <eric.y.miao@gmail.com> wrote:
>
> I see no reason why set_pxa_fb_info() cannot be exported, though
> its primary use is in the board setup code.

Yup, I see now. In the v6 patchset, I managed to use set_pxa_fb_info
by converting am200epd to a builtin and also changing the way we do
setup_fb for metronomefb. So I'm able to use set_pxa_fb_info without
changes now. :-)

>
>> I started thinking about maybe creating something different, like
>> maybe set_mod_pxa_fb_info that would work more dynamically (ie: alloc
>> a platform_device dynamically, thus making it possible for
>> device_release to work, rather than using a static struct
>> pxa_device_fb) and allow for module support without requiring any
>> exports other than itself. Is this something that's of interest  or
>> should I focus on the former?
>
> That sounds a bit trickier maybe we should avoid.
>

Agreed.

Thanks,
jaya

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
