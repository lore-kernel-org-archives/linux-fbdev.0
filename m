From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 13 Jan 2011 04:11:21 +0000
Subject: Re: [PATCH] radeonfb: Let hwmon driver probe the "monid" I2C bus
Message-Id: <20110113041121.GD12013@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110111162352.5a634e9e@endymion.delvare>
In-Reply-To: <20110111162352.5a634e9e@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, Jan 11, 2011 at 04:23:52PM +0100, Jean Delvare wrote:
> Some Radeon cards have an I2C-based thermal sensor chip connected to
> the "monid" I2C bus. Set the I2C probing class of this bus properly so
> that hwmon drivers can detect devices on it and bind to them.
> 
> This closes kernel.org bug #26172.
> 
> Reported-by: Alexander Goomenyuk <emerg.reanimator@gmail.com>
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> Ben, please let me know if you have any objection, and if you don't,
> please let me know if you want to pick this patch or if you prefer that
> I push it through my hwmon tree.
> 
I can take this through the fbdev tree if Ben's happy with it.
