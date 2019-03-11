From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 11 Mar 2019 08:18:14 +0000
Subject: Re: [PATCH] FBTFT: fbtft-bus: Fix code style problems
Message-Id: <20190311081814.GD2434@kadam>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190309214852.12233-1-dante.paz@gmail.com>
In-Reply-To: <20190309214852.12233-1-dante.paz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dante Paz <dante.paz@gmail.com>
Cc: devel@driverdev.osuosl.org, Dante Paz <dpaz@unc.edu.ar>, linux-fbdev@vger.kernel.org, nishadkamdar@gmail.com, leobras.c@gmail.com, gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org, renatoys08@gmail.com

I feel like you need to break the patch up a bit and do the white
space fixes separate from the other changes.

(Probably you're going to have to redo this several times because it's
hard to review when it's so mixed up with multiple changes at the same
time).

regards,
dan carpenter
