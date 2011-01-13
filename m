From: Dave Airlie <airlied@gmail.com>
Date: Thu, 13 Jan 2011 04:44:53 +0000
Subject: Re: [PATCH] radeonfb: Let hwmon driver probe the "monid" I2C bus
Message-Id: <AANLkTikNPiXHe1ECSK_SpiTKdLzaBXE6DER96i++gLHa@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110111162352.5a634e9e@endymion.delvare>
In-Reply-To: <20110111162352.5a634e9e@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, Jan 13, 2011 at 2:11 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Tue, Jan 11, 2011 at 04:23:52PM +0100, Jean Delvare wrote:
>> Some Radeon cards have an I2C-based thermal sensor chip connected to
>> the "monid" I2C bus. Set the I2C probing class of this bus properly so
>> that hwmon drivers can detect devices on it and bind to them.
>>
>> This closes kernel.org bug #26172.
>>

The radeon BIOS actually contains a table to tell us what chip is on the bus,
in the KMS driver we read this table and load the appropriate hwmon device,

There could possibly be other things on this bus than hw monitor devices.

Though radeonfb should be considered mostly dead.

Dave.
