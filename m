From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH 0/7] Detaching fbcon
Date: Mon, 12 Jun 2006 20:17:19 +0800
Message-ID: <448D5B4F.5080504@gmail.com>
References: <44856223.9010606@gmail.com>
	<448C19D7.5010706@t-online.de>	<448C83AD.9060200@gmail.com>
	<448D1C9E.7050606@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.7]
	helo=sc8-sf-list1.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FplMQ-0004dc-Q5 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 Jun 2006 05:17:38 -0700
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FplMQ-00048U-Kz for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 Jun 2006 05:17:38 -0700
Received: from py-out-1112.google.com ([64.233.166.179])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FplMP-00028t-FG
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 12 Jun 2006 05:17:38 -0700
Received: by py-out-1112.google.com with SMTP id x31so1666859pye
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 12 Jun 2006 05:17:36 -0700 (PDT)
In-Reply-To: <448D1C9E.7050606@t-online.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Knut Petersen <Knut_Petersen@t-online.de>

Knut Petersen wrote:
> Hi Tony,
> =

>> We'll use fb_restore_state and fb_save_state if available, yes, but I do=
n't
>> think we need to implement unbind and bind.  For one, as Jon and Andrew
>> has pointed out, drivers should have no concept of binding. (That's why =
the
>> patch has escalated to VT binding).
>>
>>  =

>>
> Well, it does not matter if it=B4s the fbcon or vt layer that does the
> binding. I agree with Jon and Andrew that vt binding is the better
> way.
> =

>> And why force drivers to have an fb_restore_state/fb_save_state just to
>> unbind/bind?  This is going to penalize 10's of drivers that don't need
>> it.  Just make this feature an experimental kconfig option, or make this
>> available as a boot option.
>>  =

>>
> An experimental feature could be "Allow all framebuffer drivers to unbind=
".

Yes, this was what I meant.

> Non-experimental behaviour really should be to allow unbinding
> only if the framebuffer driver allows it. The fbcon and vt layer simply
> does not know if it is safe, and thus they have to interrogate the
> hardware layer that knows the answer.
> =

> Your current proposal is to allow unbinding and removal of the framebuffer
> driver and the fbcon layer, no matter what the result will be. I don=B4t =
think
> that this is ok.  There is  John User that tries to switch to text mode, =
and
> he will complain if it does leave his hardware in an unusable state.

This I disagree with you.  The view that an operation should be totally
done 100% within the kernel is very utopic.  We already have features that
require both the kernel and userspace for them to work. The nearest example
is suspend/resume. It's good if you can make suspend/resume work without
additional effort, but that's not the case. Majority of users still need
utilities such as vbetool.

> =

> I suggest to add the fb_unbinding / fb_binding fbops and to only allow
> unbinding if we know that it will not leave the video hardware in a state
> that is unusable for proper operation.
> =

> If there is nothing to be done inside those two fbops, they simply return
> 0.
> =

> Other framebuffer drivers set the hardware to a state that is completely
> unusable by a textmode console and that is incompatible with X. These
> might need to know if X is active to decide if unbinding makes any sense =
at
> that specific moment.

This is very ugly. Drivers should not care whether it's safe to load or
unload, unbind or bind, or whether a specific application is open or not.
This is not their job, this should be the job of the higher layer or an
arbiter.  And yes, the state of graphics is currently ugly, witness the
very long threads on how to to make everything work together.

Right now, the only thing I can claim is that trying to do an fbdev
operation while inside X will result in undefined, if not fatal behavior.
Don't do it. And no matter how many ugly hacks and workarounds we add
for the framebuffer layer, this will always be true.

Tony
