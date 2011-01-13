From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 13 Jan 2011 08:22:58 +0000
Subject: Re: [PATCH] radeonfb: Let hwmon driver probe the "monid" I2C bus
Message-Id: <20110113092258.20979268@endymion.delvare>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110111162352.5a634e9e@endymion.delvare>
In-Reply-To: <20110111162352.5a634e9e@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, 13 Jan 2011 14:44:53 +1000, Dave Airlie wrote:
> On Thu, Jan 13, 2011 at 2:11 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> > On Tue, Jan 11, 2011 at 04:23:52PM +0100, Jean Delvare wrote:
> >> Some Radeon cards have an I2C-based thermal sensor chip connected to
> >> the "monid" I2C bus. Set the I2C probing class of this bus properly so
> >> that hwmon drivers can detect devices on it and bind to them.
> >>
> >> This closes kernel.org bug #26172.
> >>
> 
> The radeon BIOS actually contains a table to tell us what chip is on the bus,
> in the KMS driver we read this table and load the appropriate hwmon device,
> 
> There could possibly be other things on this bus than hw monitor devices.

I know that, but...

> Though radeonfb should be considered mostly dead.

... I doubt anybody is interested in investing that much worktime in
radeonfb any longer.

-- 
Jean Delvare
