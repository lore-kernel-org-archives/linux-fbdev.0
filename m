From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.26-rc9 4/5] am200epd: convert to
	shared fb and use gpio api
Date: Sat, 2 Aug 2008 09:32:13 -0400
Message-ID: <45a44e480808020632r691e964bjaa88dfc529e02d21@mail.gmail.com>
References: <1217422269-11093-1-git-send-email-jayakumar.lkml@gmail.com>
	<1217422269-11093-5-git-send-email-jayakumar.lkml@gmail.com>
	<20080731174642.a55e1e39.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KPHDU-00031A-PH for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Aug 2008 06:32:16 -0700
Received: from nf-out-0910.google.com ([64.233.182.191])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KPHDT-0007y7-7x
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Aug 2008 06:32:16 -0700
Received: by nf-out-0910.google.com with SMTP id g16so453450nfd.2
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 02 Aug 2008 06:32:13 -0700 (PDT)
In-Reply-To: <20080731174642.a55e1e39.krzysztof.h1@poczta.fm>
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

On Thu, Jul 31, 2008 at 11:46 AM, Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:
> On Wed, 30 Jul 2008 08:51:08 -0400
> Jaya Kumar <jayakumar.lkml@gmail.com> wrote:
>
>> +
>> +static irqreturn_t am200_handle_irq(int irq, void *dev_id)
>> +{
>
> You may pass metronomefb_par* here to avoid one reference.

Agreed.

>> +     ret = wait_event_interruptible_timeout(par->waitq,
>> +                                     gpio_get_value(RDY_GPIO_PIN), HZ);
>> +     return ret;
>> +}
>
> You may drop the ret variable here.

Agreed.

>> +     am200_device = platform_device_alloc("metronomefb", -1);
>
> The second parameter is instance id. Probably 0 is better here.

I would like to mark it as single instance only, -1. I see in platform.c:

      if (pdev->id != -1)
                snprintf(pdev->dev.bus_id, BUS_ID_SIZE, "%s.%d", pdev->name,
                         pdev->id);
        else
                strlcpy(pdev->dev.bus_id, pdev->name, BUS_ID_SIZE);


>> +     am200_presetup_fb();
>
> Should the am200 be set up in case of error?

Agreed, will fix the error.

Thanks,
jaya

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
