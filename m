From: Olivier Sobrie <olivier@sobrie.be>
Date: Thu, 22 Mar 2012 07:32:43 +0000
Subject: Re: [PATCH v2] udlfb: Fix invalid return codes in edid sysfs entry store function
Message-Id: <20120322073243.GA3977@hposo>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1330499200-20819-1-git-send-email-olivier@sobrie.be>
In-Reply-To: <1330499200-20819-1-git-send-email-olivier@sobrie.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, Mar 21, 2012 at 06:29:39PM +0000, Florian Tobias Schandinat wrote:
> On 02/29/2012 07:06 AM, Olivier Sobrie wrote:
> > Return a negative errno instead of zero in the write function of
> > the sysfs entry in case of error.
> > Also add a check on the return value of dlfb_setup_modes().
> > 
> > Signed-off-by: Olivier Sobrie <olivier@sobrie.be>
> 
> As Bernie did agree in the pull request, I applied this patch.
ok!
Thank you,

-- 
Olivier
