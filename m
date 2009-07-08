From: "Rajashekhara, Sudhakar" <sudhakar.raj-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v5] Frame Buffer driver for TI DA8xx/OMAP-L1xx
Date: Wed, 8 Jul 2009 15:06:13 +0530
Message-ID: <19130.4517248229$1247045901@news.gmane.org>
References: <1246858151-16995-1-git-send-email-sudhakar.raj@ti.com>
	<20090707220943.479940d7.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20090707220943.479940d7.krzysztof.h1-IjDXvh/HVVUAvxtiuMwx3w@public.gmane.org>
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

On Wed, Jul 08, 2009 at 01:39:43, Krzysztof Helt wrote:
> On Mon,  6 Jul 2009 01:29:11 -0400
> "Rajashekhara, Sudhakar" <sudhakar.raj-l0cyMroinI0@public.gmane.org> wrote:
> 
> > Adds LCD controller (LCDC) driver for TI's DA8xx/OMAP-L1xx architecture.
> > LCDC specifications can be found at http://www.ti.com/litv/pdf/sprufm0a.
> > 
> > LCDC on DA8xx consists of two independent controllers, the Raster 
> > Controller and the LCD Interface Display Driver (LIDD) controller. 
> > LIDD further supports character and graphic displays.
> > 
> > This patch adds support for the graphic display (Sharp LQ035Q3DG01) 
> > found on the DA830 based EVM. The EVM details can be found at:
> > http://support.spectrumdigital.com/boards/dskda830/revc/.
> > 
> > Signed-off-by: Sudhakar Rajashekhara <sudhakar.raj-l0cyMroinI0@public.gmane.org>
> > Signed-off-by: Pavel Kiryukhin <pkiryukhin-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
> > Signed-off-by: Steve Chen <schen-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
> > ---
> >  This patch applies to Linus's Kernel tree.
> > 
> 
> Acked-by: Krzysztof Helt <krzysztof.h1-5tc4TXWwyLM@public.gmane.org>
> 

Thanks. What I should do to get this patch to Linus's tree?

Regards,
Sudhakar
