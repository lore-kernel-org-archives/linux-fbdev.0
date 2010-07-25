From: Dave Airlie <airlied@gmail.com>
Date: Sun, 25 Jul 2010 08:42:48 +0000
Subject: Re: [Nouveau] [PATCH v2] vga16fb: refuse to load in face of other
Message-Id: <AANLkTimQZ6_+o=3pGa6hGbeFU99RMPFRmO+ndMZDHZMS@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100720191923.GA11056@joi.lan>
	<20100722172039.e935c67d.akpm@linux-foundation.org>
	<20100723131034.GA6618@joi.lan>
In-Reply-To: <20100723131034.GA6618@joi.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marcin Slusarz <marcin.slusarz@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, nouveau@lists.freedesktop.org, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Fri, Jul 23, 2010 at 11:10 PM, Marcin Slusarz
<marcin.slusarz@gmail.com> wrote:
> On Thu, Jul 22, 2010 at 05:20:39PM -0700, Andrew Morton wrote:
>> On Tue, 20 Jul 2010 21:19:23 +0200
>> Marcin Slusarz <marcin.slusarz@gmail.com> wrote:
>>
>> > We don't want vga16fb to mess with hardware initialized by other driver.
>> > Detect it and refuse to load.
>> > It fixes nouveau interrupt storm on some machines.

Can't we keep this all inside vga16fb? just have it walk PCI tree
looking for a primary VGA card, and if it has a driver bound, just
refuse to bind.

Dave.
