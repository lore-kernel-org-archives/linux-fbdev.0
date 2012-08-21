From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Tue, 21 Aug 2012 22:12:55 +0000
Subject: Re: [PATCHv3 3/9] serial: vt8500: Add devicetree support for vt8500-serial
Message-Id: <20120821231255.71a7515a@pyramind.ukuu.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1345582058-2291-1-git-send-email-linux@prisktech.co.nz>
 <1345582058-2291-4-git-send-email-linux@prisktech.co.nz>
In-Reply-To: <1345582058-2291-4-git-send-email-linux@prisktech.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, 22 Aug 2012 08:47:32 +1200
Tony Prisk <linux@prisktech.co.nz> wrote:

> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---
>  drivers/tty/serial/vt8500_serial.c |   37 ++++++++++++++++++++++++++++++++----
>  1 file changed, 33 insertions(+), 4 deletions(-)

Can we have a comment attached to a change this size. In particular one
describing why it gone from 4 to 6 ports, and why the port id twiddling.

Is there a reason you can't use the device tree port id ?

What are the regression risks for existing users expecting the pdev->id
binding ?
