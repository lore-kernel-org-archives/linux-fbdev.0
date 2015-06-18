From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 18 Jun 2015 04:45:40 +0000
Subject: Re: [PATCH v2 0/9] fix sm7xxfb
Message-Id: <20150618044540.GA3779@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1434540288-8289-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20150618044351.GA26238@kroah.com>
In-Reply-To: <20150618044351.GA26238@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: devel@driverdev.osuosl.org, Joe Perches <joe@perches.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jun 17, 2015 at 09:43:51PM -0700, Greg Kroah-Hartman wrote:
> On Wed, Jun 17, 2015 at 04:54:39PM +0530, Sudip Mukherjee wrote:
> > fixing the few remaining issues of sm7xxfb before sending the patch to
> > remove it from staging.

Oh, the BIG_ENDIAN defines need to be fixed up, surely that can be done
in a more "correct" way.

thanks,

greg k-h
