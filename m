From: "Eric Miao" <eric.y.miao@gmail.com>
Subject: Re: [PATCH 3/8] lcd: allow lcd device to handle
	mode change events
Date: Mon, 1 Sep 2008 09:56:23 +0800
Message-ID: <f17812d70808311856u5ba27570kd490e05594ed455e@mail.gmail.com>
References: <f17812d70808290026y39163cccy2d4b1fa3b30c8625@mail.gmail.com>
	<20080831092009.69d2f56a.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KZyeW-00065f-7O for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 31 Aug 2008 18:56:24 -0700
Received: from yx-out-1718.google.com ([74.125.44.155])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KZyeW-0002VN-1W
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 31 Aug 2008 18:56:24 -0700
Received: by yx-out-1718.google.com with SMTP id 3so765493yxi.82
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 31 Aug 2008 18:56:23 -0700 (PDT)
In-Reply-To: <20080831092009.69d2f56a.krzysztof.h1@poczta.fm>
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
Cc: linux-fbdev-devel@lists.sourceforge.net, ARM Linux <linux-arm-kernel@lists.arm.linux.org.uk>

On Sun, Aug 31, 2008 at 3:20 PM, Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:
> On Fri, 29 Aug 2008 15:26:46 +0800
> "Eric Miao" <eric.y.miao@gmail.com> wrote:
>
>> Some LCD panels are capable of different resolutions, and is allowed
>> to change at run-time, so to make "struct lcd_device" to be able to
>> handle mode change events here.
>>
>> Signed-off-by: Eric Miao <eric.miao@marvell.com>
>> ---
>
> Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>
>

OK, thanks. I'll queue this patch for next merge window then.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
