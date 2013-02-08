From: Alexander Holler <holler@ahsoftware.de>
Date: Fri, 08 Feb 2013 09:53:40 +0000
Subject: Re: [PATCH 2/3 v2] fb: udlfb: fix hang at disconnect
Message-Id: <5114CB24.2070509@ahsoftware.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <51071E21.9030008@ahsoftware.de> <5107A5ED.7020009@ahsoftware.de> <5107AE4F.9000809@ahsoftware.de> <5107F014.4030704@ahsoftware.de> <5108329E.2050802@ahsoftware.de> <20130204011413.GA6413@kroah.com> <510FA409.2080201@ahsoftware.de> <51100930.6080405@ahsoftware.de> <20130204192514.GA32318@kroah.com> <5110AFEC.8020406@ahsoftware.de> <20130205172245.GA1426@kroah.com> <5111431D.8070906@ahsoftware.de> <CAPM=9tzNeQTXAmvZZ1RCmn6uTYHvweYKKnSPYAh7QYRGNMgeUw@mail.gmail.com>
In-Reply-To: <CAPM=9tzNeQTXAmvZZ1RCmn6uTYHvweYKKnSPYAh7QYRGNMgeUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Airlie <airlied@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Bernie Thompson <bernie@plugable.com>, Steve Glendinning <steve.glendinning@shawell.net>, stable@vger.kernel.org

Am 08.02.2013 05:07, schrieb Dave Airlie:
>>
>> But I've just switched to udl (instead of udlfb) and will see if I can fix
>> the bugs there to make it usable as a console. udl is a rewrite of udlfb
>> with some additional features (e.g. drm), so hopefully fixing the remaining
>> problems there will require less work.
>
> I may have fixed the major udl problem with being a console, patch was
> posted to dri-devel yesterday, and I've pushed it into -next.

Thanks a lot. I will check it.

Regards,

Alexander

