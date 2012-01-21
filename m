From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Sat, 21 Jan 2012 12:33:42 +0000
Subject: Re: [PATCH 1/4] drivers/video/backlight/wm831x_bl.c: use devm_ functions
Message-Id: <20120121123341.GA10206@opensource.wolfsonmicro.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1327094732-9050-1-git-send-email-Julia.Lawall@lip6.fr>
 <1327094732-9050-2-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1327094732-9050-2-git-send-email-Julia.Lawall@lip6.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, Ian Lartey <ian@opensource.wolfsonmicro.com>, Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, Richard Purdie <rpurdie@rpsys.net>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jan 20, 2012 at 10:25:29PM +0100, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> The various devm_ functions allocate memory that is released when a driver
> detaches.  This patch uses these functions for data that is allocated in
> the probe function of a platform device and is only freed in the remove
> function.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
