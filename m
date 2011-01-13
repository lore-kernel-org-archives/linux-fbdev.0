From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 13 Jan 2011 04:50:10 +0000
Subject: Re: [PATCH] radeonfb: Let hwmon driver probe the "monid" I2C bus
Message-Id: <1294894210.9586.73.camel@pasglop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110111162352.5a634e9e@endymion.delvare>
In-Reply-To: <20110111162352.5a634e9e@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, 2011-01-13 at 14:44 +1000, Dave Airlie wrote:
> The radeon BIOS actually contains a table to tell us what chip is on
> the bus,
> in the KMS driver we read this table and load the appropriate hwmon
> device,
> 
> There could possibly be other things on this bus than hw monitor
> devices.
> 
> Though radeonfb should be considered mostly dead. 

I want to test that on a few powermacs first. "probing" i2c can be
destructive and f* knows what Apple put on those busses on some
machines.

Haven't had a chance to look much yet.

Cheers,
Ben.


