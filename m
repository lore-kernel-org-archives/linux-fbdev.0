From: Rob Landley <rob@landley.net>
Date: Thu, 23 Aug 2012 21:29:37 +0000
Subject: Re: [PATCHv3 3/9] serial: vt8500: Add devicetree support for
Message-Id: <5036A0C1.4030209@landley.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345582058-2291-1-git-send-email-linux@prisktech.co.nz>
 <20120821231255.71a7515a@pyramind.ukuu.org.uk>
 <1345617278.7491.4.camel@gitbox> <201208220644.18059.arnd@arndb.de>
In-Reply-To: <201208220644.18059.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 08/22/2012 01:44 AM, Arnd Bergmann wrote:
> On Wednesday 22 August 2012, Tony Prisk wrote:
>> The original patch was very simple, but I revisited it to fix other
>> issues and forgot to add the relevant comments.
>>
>> Port size is changed to fix a problem - WM8505 actually had 6 uart's
>> defined in platform data but the vt8500_ports variable was only 4.
>>
>> I have added devicetree port id support as well.
> 
> If you do multiple things in one driver, you should normally send multiple
> patches as well, each with a description why that change is done.
> It may seem silly at first to send out a one-line patch next to a 100-line
> patch for the same file, but those cases are actually the ones where it's
> most important.

Think of us poor git-bisect monkeys who have no idea why something broke
but can (purely mechanically) figure out which commit did it. If it's a
patch that does three unrelated things, we're kinda stuck.

Rob
-- 
GNU/Linux isn't: Linux=GPLv2, GNU=GPLv3+, they can't share code.
Either it's "mere aggregation", or a license violation.  Pick one.
