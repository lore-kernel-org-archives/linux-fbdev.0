From: Alexander Holler <holler@ahsoftware.de>
Date: Tue, 05 Feb 2013 17:36:29 +0000
Subject: Re: [PATCH 2/3 v2] fb: udlfb: fix hang at disconnect
Message-Id: <5111431D.8070906@ahsoftware.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <51071E21.9030008@ahsoftware.de> <5107A5ED.7020009@ahsoftware.de> <5107AE4F.9000809@ahsoftware.de> <5107F014.4030704@ahsoftware.de> <5108329E.2050802@ahsoftware.de> <20130204011413.GA6413@kroah.com> <510FA409.2080201@ahsoftware.de> <51100930.6080405@ahsoftware.de> <20130204192514.GA32318@kroah.com> <5110AFEC.8020406@ahsoftware.de> <20130205172245.GA1426@kroah.com>
In-Reply-To: <20130205172245.GA1426@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Bernie Thompson <bernie@plugable.com>, Steve Glendinning <steve.glendinning@shawell.net>, stable@vger.kernel.org

Am 05.02.2013 18:22, schrieb Greg KH:
> On Tue, Feb 05, 2013 at 08:08:28AM +0100, Alexander Holler wrote:
>> Am 04.02.2013 20:25, schrieb Greg KH:

>>> Where was that urb when the disconnect happened?  The USB core should
>>> call your urb callback for any outstanding urbs at that point in time,
>>> with the proper error flag being set, are you handling that properly?
>>
>> I don't know where that urb is as I don't handle it.
>
> What do you mean by that?  The urb is being sent back to your driver,
> right?  If not, that's a bug, but please be sure that your urb callback
> isn't really being called.

I meant it isn't _my_ driver. ;)

I'm just trying to add some w=C3=BCrgarounds without having the need to=20
rewrite the whole driver.

In regard to that "urb missing problem", I think I've just named it=20
wrong and the actual problem is a race-condition between the semaphore=20
handling (which is used to keep track of the urbs) and the urb handling=20
inside the driver.

But I've just switched to udl (instead of udlfb) and will see if I can=20
fix the bugs there to make it usable as a console. udl is a rewrite of=20
udlfb with some additional features (e.g. drm), so hopefully fixing the=20
remaining problems there will require less work.

Regards,

Alexander

