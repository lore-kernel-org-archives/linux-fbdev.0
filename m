From: "Rajashekhara, Sudhakar" <sudhakar.raj-l0cyMroinI0@public.gmane.org>
Subject: RE: [Linux-fbdev-devel] [PATCH v3] Frame Buffer driver for TI
	DA8xx/OMAP-L1xx
Date: Tue, 30 Jun 2009 11:54:44 +0530
Message-ID: <34078.0357983478$1246343284@news.gmane.org>
References: <1245841101-3095-1-git-send-email-sudhakar.raj@ti.com>
	<20090626071855.22518d52.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20090626071855.22518d52.krzysztof.h1-IjDXvh/HVVUAvxtiuMwx3w@public.gmane.org>
Content-Language: en-us
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Content-Type: text/plain; charset="us-ascii"
To: 'Krzysztof Helt' <krzysztof.h1-IjDXvh/HVVUAvxtiuMwx3w@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, 'Pavel Kiryukhin' <pkiryukhin-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>

Hi,

On Fri, Jun 26, 2009 at 10:48:55, Krzysztof Helt wrote:
> On Wed, 24 Jun 2009 06:58:21 -0400
> "Rajashekhara, Sudhakar" <sudhakar.raj-l0cyMroinI0@public.gmane.org> wrote:
> 
> > Adds LCD controller (LCDC) driver for TI's DA8xx/OMAP-L1xx architecture.
> > LCDC specifications can be found at http://www.ti.com/litv/pdf/sprufm0a.
> > 
> > LCDC on DA8xx consists of two independent controllers, the Raster Controller
> > and the LCD Interface Display Driver (LIDD) controller. LIDD further supports
> > character and graphic displays.
> > 
> > This patch adds support for the graphic display (Sharp LQ035Q3DG01) found on
> > the DA830 based EVM. The EVM details can be found at:
> > http://support.spectrumdigital.com/boards/dskda830/revc/.
> > 
> > Signed-off-by: Sudhakar Rajashekhara <sudhakar.raj-l0cyMroinI0@public.gmane.org>
> > Signed-off-by: Pavel Kiryukhin <pkiryukhin-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
> > Signed-off-by: Steve Chen <schen-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
> > ---

[...]

> 
> The true color modes do not use the palette entry. I assume
> that the value below forces controller to use true color mode.
> 
> > +		palette[0] = 0x4000;
> > +	}
> > +

You are right. The above line enables the true color mode.

I tested the driver with the changes suggested by you. I'll
be submitting the v4 version of the patch soon.

Regards,
Sudhakar
