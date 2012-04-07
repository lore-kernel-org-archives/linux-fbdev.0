From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Sat, 07 Apr 2012 11:48:04 +0000
Subject: Re: [PATCH] kyrofb: fix on x86_64
Message-Id: <4F802974.4000405@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <201203212336.55396.linux@rainbow-software.org> <20120322000104.GB26543@linux-sh.org> <201204071338.30521.linux@rainbow-software.org>
In-Reply-To: <201204071338.30521.linux@rainbow-software.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

On 04/07/2012 11:38 AM, Ondrej Zary wrote:
> On Thursday 22 March 2012 01:01:05 Paul Mundt wrote:
>> On Wed, Mar 21, 2012 at 11:36:50PM +0100, Ondrej Zary wrote:
>>> kyrofb is completely broken on x86_64 because the registers are defined
>>> as unsigned long. Change them to u32 to make the driver work.
>>> Tested with Hercules 3D Prophet 4000XT.
>>>
>>> Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
>>
>> Looks fine to me.
>>
>> Acked-by: Paul Mundt <lethal@linux-sh.org>
> 
> When will this go in?

Probably between -rc2 and -rc3. I've already applied this in my private
tree, I just needed a few days off after the last merge window.


Best regards,

Florian Tobias Schandinat
