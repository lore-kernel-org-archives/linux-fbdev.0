From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 24 Mar 2011 22:53:15 +0000
Subject: Re: [GIT PULL] viafb fixes for 2.6.39
Message-Id: <20110324225315.GB7338@linux-sh.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4D89E6B5.8080005@gmx.de>
In-Reply-To: <4D89E6B5.8080005@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, Mar 23, 2011 at 01:25:25PM +0100, Florian Tobias Schandinat wrote:
> please pull the viafb fixes below.
> They fix the handling of refresh rates which should now work (or at least 
> work much better than it did before). Especially the initial refresh rate 
> as passed in via module parameter is now handled correct. Before these 
> patches this didn't work for higher refresh rates.
> 
Pulled, thanks.
