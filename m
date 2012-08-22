From: Tony Prisk <linux@prisktech.co.nz>
Date: Wed, 22 Aug 2012 06:34:38 +0000
Subject: Re: [PATCHv3 3/9] serial: vt8500: Add devicetree support for
Message-Id: <1345617278.7491.4.camel@gitbox>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345582058-2291-1-git-send-email-linux@prisktech.co.nz>
 <1345582058-2291-4-git-send-email-linux@prisktech.co.nz>
 <20120821231255.71a7515a@pyramind.ukuu.org.uk>
In-Reply-To: <20120821231255.71a7515a@pyramind.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, 2012-08-21 at 23:12 +0100, Alan Cox wrote:
> On Wed, 22 Aug 2012 08:47:32 +1200
> Tony Prisk <linux@prisktech.co.nz> wrote:
> 
> > Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> > ---
> >  drivers/tty/serial/vt8500_serial.c |   37 ++++++++++++++++++++++++++++++++----
> >  1 file changed, 33 insertions(+), 4 deletions(-)
> 
> Can we have a comment attached to a change this size. In particular one
> describing why it gone from 4 to 6 ports, and why the port id twiddling.
> 
> Is there a reason you can't use the device tree port id ?
> 
> What are the regression risks for existing users expecting the pdev->id
> binding ?
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

Sorry Alan,

The original patch was very simple, but I revisited it to fix other
issues and forgot to add the relevant comments.

Port size is changed to fix a problem - WM8505 actually had 6 uart's
defined in platform data but the vt8500_ports variable was only 4.

I have added devicetree port id support as well.

No regression risks as the entire platform is being converted to
devicetree and existing code dropped in this patchset.

Patchv4 3/9 to follow.

Regards

Tony Prisk

