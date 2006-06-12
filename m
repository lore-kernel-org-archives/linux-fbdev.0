From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [Linux-fbdev-devel] [PATCH 0/7] Detaching fbcon
Date: Mon, 12 Jun 2006 22:15:50 +0800
Message-ID: <448D7716.5070205@gmail.com>
References: <44856223.9010606@gmail.com> <448C19D7.5010706@t-online.de>	<448C83AD.9060200@gmail.com> <448D1C9E.7050606@t-online.de>	<448D5B4F.5080504@gmail.com> <a5d587fb0606120628o203941c3h761bfffbb6ec08f7@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751983AbWFLOQI@vger.kernel.org>
In-Reply-To: <a5d587fb0606120628o203941c3h761bfffbb6ec08f7@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, Knut Petersen <Knut_Petersen@t-online.de>, hramrach@centrum.cz

Michal Suchanek wrote:
> On 6/12/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
>>> Non-experimental behaviour really should be to allow unbinding
>>> only if the framebuffer driver allows it. The fbcon and vt layer si=
mply
>>> does not know if it is safe, and thus they have to interrogate the
>>> hardware layer that knows the answer.
>>>
>>> Your current proposal is to allow unbinding and removal of the fram=
ebuffer
>>> driver and the fbcon layer, no matter what the result will be. I do=
n=C2=B4t think
>>> that this is ok.  There is  John User that tries to switch to text =
mode, and
>>> he will complain if it does leave his hardware in an unusable state=
=2E
>> This I disagree with you.  The view that an operation should be tota=
lly
>> done 100% within the kernel is very utopic.  We already have feature=
s that
>> require both the kernel and userspace for them to work. The nearest =
example
>> is suspend/resume. It's good if you can make suspend/resume work wit=
hout
>> additional effort, but that's not the case. Majority of users still =
need
>> utilities such as vbetool.
>=20
> Well, I guess that the fb driver should try to restore the original
> mode (ie text mode on x86) on unload. And it is either considered
> flawed if it doesnt or it should indicate somewhere that it does not
> know how to unload itself.

Well, failure to implement proper suspend and resume by a driver does n=
ot
stop the entire suspend/resume process, does it? Even if it results
in a blank screen. It doesn't because we have a userspace options and
tools that complements the kernel side. So why should it be any differe=
nt
in this case?=20

Some drivers, i810fb and rivafb, saves the hardware state on the
first open, and restores the hardware state on the last close. This
is usually sufficient for them to restore the hardware to VGA text
mode on unload. It would be nice if we can implement something like thi=
s
for all drivers, but failure to do so should not be a reason to stop th=
e
entire process.

> I like the possibility to change X resolution using fbset (from insid=
e
> X). I use it to correct problems caused by crashed X programs that
> change resolution. But I run X with the UseFbDev option. The X server
> would be probably quite unhappy if I removed the fb driver but since
> it uses the fb device the driver should not unload.

If X is using fbdev, then X is also holding a reference count on the
driver.  And the driver will not unload even if you try to.

Tony
