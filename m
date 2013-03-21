From: Paul Bolle <pebolle@tiscali.nl>
Date: Thu, 21 Mar 2013 20:27:36 +0000
Subject: Re: [PATCH] video: nuc900fb: remove "config FB_NUC900_DEBUG"
Message-Id: <1363897656.1390.155.camel@x61.thuisdomein>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1363897258.1390.153.camel@x61.thuisdomein>
In-Reply-To: <1363897258.1390.153.camel@x61.thuisdomein>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2013-03-21 at 21:20 +0100, Paul Bolle wrote:
> When the NUC900 LCD Controller Driver got added (in v3.4) a Kconfig
> entry for FB_NUC900_DEBUG got added too. It has never been used. It
> appears that its users were dropped during review. Anyhow, this entry
> can be removed.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>

Please s/v3.4/v2.6.34/.


Paul Bolle

