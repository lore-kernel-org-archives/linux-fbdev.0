From: Dmitry <dbaryshkov@gmail.com>
Subject: Re: [fbdev] Lockdep error
Date: Tue, 23 Sep 2008 13:53:14 +0400
Message-ID: <bc64b4640809230253s79e0c257qfd559787e15ef8d8@mail.gmail.com>
References: <20080915122152.GA4570@doriath.ww600.siemens.net>
	<20080916233916.4f9c0dfd.krzysztof.h1@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dbaryshkov@gmail.com>) id 1Ki4a9-0000Jb-12
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 23 Sep 2008 09:53:21 +0000
Received: from hs-out-0708.google.com ([64.233.178.249])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ki4a3-0000Yn-BC for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 23 Sep 2008 09:53:20 +0000
Received: by hs-out-0708.google.com with SMTP id 55so425943hsc.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 23 Sep 2008 02:53:14 -0700 (PDT)
In-Reply-To: <20080916233916.4f9c0dfd.krzysztof.h1@wp.pl>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Krzysztof Helt <krzysztof.h1@wp.pl>
Cc: rpurdie@rpsys.net, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com

2008/9/17 Krzysztof Helt <krzysztof.h1@wp.pl>:
> On Mon, 15 Sep 2008 16:21:52 +0400
> Dmitry Baryshkov <dbaryshkov@gmail.com> wrote:
>
>> Hi,
>>
>> After doing
>> # echo 1 > /sys/class/graphics/fb0/blank
>> I got the following in my kernel log:
>>
>> =============================================
>> [ INFO: possible recursive locking detected ]
>> 2.6.27-rc6-00086-gda63874-dirty #97
>> ---------------------------------------------
>> echo/1564 is trying to acquire lock:
>>  ((fb_notifier_list).rwsem){..--}, at: [<c005a384>] __blocking_notifier_call_chain+0x38/0x6c
>>
>
> Does the patch below fix the problem for you?

Sorry for the delay.
Yes, the patch does fix the issue for me. Thank you.

>
> Kind regards,
> Krzysztof
>
> diff -urp linux-ref/drivers/video/console/fbcon.c linux-mm/drivers/video/console/fbcon.c
> --- linux-ref/drivers/video/console/fbcon.c     2008-09-05 23:38:47.000000000 +0200
> +++ linux-mm/drivers/video/console/fbcon.c      2008-09-16 23:30:52.309604454 +0200
> @@ -2400,11 +2400,15 @@ static int fbcon_blank(struct vc_data *v
>
>        if (!fbcon_is_inactive(vc, info)) {
>                if (ops->blank_state != blank) {
> +                       int ret = 1;
> +
>                        ops->blank_state = blank;
>                        fbcon_cursor(vc, blank ? CM_ERASE : CM_DRAW);
>                        ops->cursor_flash = (!blank);
>
> -                       if (fb_blank(info, blank))
> +                       if (info->fbops->fb_blank)
> +                               ret = info->fbops->fb_blank(blank, info);
> +                       if (ret)
>                                fbcon_generic_blank(vc, info, blank);
>                }
>
>



-- 
With best wishes
Dmitry

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
