From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 13 Jul 2011 08:16:01 +0000
Subject: Re: [PATCH v3] video: Add Aeroflex Gaisler GRVGA framebuffer device driver
Message-Id: <20110713081600.GC13701@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1309850959-8198-1-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1309850959-8198-1-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, Jul 05, 2011 at 09:29:19AM +0200, Kristoffer Glembo wrote:
> This patch adds support for the GRVGA framebuffer IP core from Aeroflex Gaisler.
> The device is used in LEON SPARCV8 based System on Chips. Documentation can
> be found here: www.gaisler.com/products/grlib/grip.pdf.
> 
> Signed-off-by: Kristoffer Glembo <kristoffer@gaisler.com>

The updated version looks fine to me, I've added it to the 3.1 queue.
