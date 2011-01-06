From: David Miller <davem@davemloft.net>
Date: Thu, 06 Jan 2011 22:29:06 +0000
Subject: Re: Using s3virge card in Sun Blade 2000
Message-Id: <20110106.142906.226774601.davem@davemloft.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110106204240.GA6361@electric-eye.fr.zoreil.com>
	<1294347036.24378.13.camel@lithium>
	<1294352651.24378.17.camel@lithium>
In-Reply-To: <1294352651.24378.17.camel@lithium>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alex.buell@munted.org.uk
Cc: romieu@fr.zoreil.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


You have to initialize par->state.vgabase in the s3fb driver to the
VGA area iomem pointer you calculated at boot time.
