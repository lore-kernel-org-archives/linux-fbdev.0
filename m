From: Roger Quadros <roger.quadros@nokia.com>
Date: Tue, 06 Apr 2010 16:03:20 +0000
Subject: Re: [PATCHv2 0/3] OMAP: DSS2: Allow us to use SDI
Message-Id: <4BBB5B48.4060804@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1268829321-29769-1-git-send-email-roger.quadros@nokia.com> <1268835050.2417.277.camel@tubuntu.research.nokia.com>
In-Reply-To: <1268835050.2417.277.camel@tubuntu.research.nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>
Cc: "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

hi Tomi,

Valkeinen Tomi (Nokia-D/Helsinki) wrote:
> Hi,
> 
> On Wed, 2010-03-17 at 13:35 +0100, Quadros Roger (Nokia-D/Helsinki)
> wrote:
>> SDI now makes use of vdds_sdi regulator supply.
>> DPI can now be disabled on systems that don't have it
>>
>> changes since v1:
>> - Incorporated review comments
>> - no more omap3xx checks for regulator enable/disable in SDI
>> - Added Kconfig option to enable/disable DPI
>>
>> Roger Quadros (3):
>>   OMAP: DSS2: Add Kconfig option for DPI display type
>>   OMAP: DSS2: Remove redundant enable/disable calls from SDI
>>   OMAP: DSS2: Use vdds_sdi regulator supply in SDI
> 
> I think this patch set looks ok. Thanks!
> 
>  Tomi
> 
> Ps. I took the liberty of removing an extra #include <plat/cpu.h>
> 
> 
What is the status of this patch set?
Is it supposed to go into your tree or Tony's tree?

cheers
-roger
