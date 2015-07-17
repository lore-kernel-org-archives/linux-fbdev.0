From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 17 Jul 2015 16:52:35 +0000
Subject: Re: [PATCH 1/3] staging: sm7xxfb: move sm712fb out of staging
Message-Id: <20150717165235.GA9138@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1437139280-7375-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1437139280-7375-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jonathan Corbet <corbet@lwn.net>, devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org

On Fri, Jul 17, 2015 at 06:51:18PM +0530, Sudip Mukherjee wrote:
> Now since all cleanups are done and the code is ready to be merged lets
> move it out of staging into fbdev location.

This is really hard for the fbdev developers to review.  Care to just
make up a single patch that adds the driver to the tree in that location
so they can read the code and review it?

thanks,

greg k-h
