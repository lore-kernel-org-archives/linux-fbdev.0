From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Thu, 18 Jun 2015 08:49:18 +0000
Subject: Re: [PATCH v2 0/9] fix sm7xxfb
Message-Id: <20150618083718.GE11984@sudip-PC>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1434540288-8289-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20150618044351.GA26238@kroah.com>
 <20150618044540.GA3779@kroah.com>
In-Reply-To: <20150618044540.GA3779@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org, Joe Perches <joe@perches.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jun 17, 2015 at 09:45:40PM -0700, Greg Kroah-Hartman wrote:
> On Wed, Jun 17, 2015 at 09:43:51PM -0700, Greg Kroah-Hartman wrote:
> > On Wed, Jun 17, 2015 at 04:54:39PM +0530, Sudip Mukherjee wrote:
> > > fixing the few remaining issues of sm7xxfb before sending the patch to
> > > remove it from staging.
> 
> Oh, the BIG_ENDIAN defines need to be fixed up, surely that can be done
> in a more "correct" way.
sure. I wanted to, but I can only check the modification on a
little-endian system so I didnot dare to.

regards
sudip
