From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.26-rc9 1/5] pxafb: add shared
	framebuffer interface
Date: Wed, 30 Jul 2008 00:39:25 +0800
Message-ID: <45a44e480807290939g1a1686d6v1d70a14089b0ccde@mail.gmail.com>
References: <1217046774-13080-1-git-send-email-jayakumar.lkml@gmail.com>
	<1217046774-13080-2-git-send-email-jayakumar.lkml@gmail.com>
	<20080729172820.d4fc7d4c.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KNsER-0001OQ-7S for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 29 Jul 2008 09:39:27 -0700
Received: from ik-out-1112.google.com ([66.249.90.179])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KNsEQ-0000Ui-M1
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 29 Jul 2008 09:39:27 -0700
Received: by ik-out-1112.google.com with SMTP id c21so4350535ika.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 29 Jul 2008 09:39:25 -0700 (PDT)
In-Reply-To: <20080729172820.d4fc7d4c.krzysztof.h1@poczta.fm>
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
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: ymiao3@marvell.com, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Tue, Jul 29, 2008 at 11:28 PM, Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:
> On Sat, 26 Jul 2008 00:32:50 -0400
> Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
>
>> These changes are to make it possible for a secondary driver to share the
>> pxafb framebuffer. The changes include:
>> - adding custom_lccr_bpp entry so that a driver can set a specific
>>   transfer width on the AMLCD bus while using a separate bits per pixel for
>>   its actual framebuffer.
>> - adding extra_video_mem entry so that a driver can tell pxafb of its
>>   additional needs.
>> - adding share_video_mem/unshare_video_mem callbacks to notify the secondary
>>   driver of the framebuffer address, to allow refcounting, and to cleanup on
>>   completion.
>>
>> Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
>
> Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>
>
>
> Jaya,
>
> This patch was already Acked-by Eric Miao. Please decide if you want to upload
> it into the RMK's patch system or I should CC it to Andrew Morton.
> Please add Acked-by tags to patches you post if they are already Acked-by.
>

Hi Krzysztof,

Thanks. My intention is to eventually push this set to rmk. Of the
original 10 of this set, I've pushed 4 to rmk which I think are
already in Linus's tree now.

I'll add the acked-by tags to this set when I post next. I was being
cautious about keeping acked-by tags on patches where I've made
changes even if minor. :-)

I think Eric has acked patch #2, the MFP conversion. But this add
shared fb interface to pxafb, patch #1 hasn't received his ack yet so
I am seeking his approval before submitting to rmk.

Thanks,
jaya

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
