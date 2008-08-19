From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [RFC 2.6.26-rc9 0/2] metronomefb and
	am200epd fixes v9
Date: Tue, 19 Aug 2008 06:13:32 -0400
Message-ID: <45a44e480808190313y1f6e89a8r79611807664b712@mail.gmail.com>
References: <1217682500-31503-1-git-send-email-jayakumar.lkml@gmail.com>
	<20080819100339.GD1067@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KVODW-0003Nf-EF for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 Aug 2008 03:13:34 -0700
Received: from wf-out-1314.google.com ([209.85.200.173])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KVODV-000053-4d
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 19 Aug 2008 03:13:34 -0700
Received: by wf-out-1314.google.com with SMTP id 27so3634095wfd.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 19 Aug 2008 03:13:32 -0700 (PDT)
In-Reply-To: <20080819100339.GD1067@flint.arm.linux.org.uk>
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
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Tue, Aug 19, 2008 at 6:03 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sat, Aug 02, 2008 at 09:08:18AM -0400, Jaya Kumar wrote:
>>
>> This is version 9 of this RFC and contains the following updates:
>> - switched to using fb notifiers. The benefit of this is that it avoids
>>   the need to add any custom callbacks in pxafb. Basically, using this
>>   mechanism there are no changes needed from the underlying host video driver.
>> - eliminates one patch. So we just have the new am200epd and changes to
>>   metronomefb.
>
> Well, somethings gone wrong - patch 1 doesn't compile.
>
> arch/arm/mach-pxa/am200epd.c: In function `am200_share_video_mem':
> arch/arm/mach-pxa/am200epd.c:151: error: structure has no member named `metromem'
> arch/arm/mach-pxa/am200epd.c:152: error: structure has no member named `host_fbinfo'
> <and lots more errors>
>

Ah sorry, it's missing metronomefb.h changes which is in patch 2/2. I
had split them to make reviewing easier. I'll post patch 2/2 to the
patch queue now.

Thanks,
jaya

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
