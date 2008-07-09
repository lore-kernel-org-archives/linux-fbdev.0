From: Andres Salomon <dilinger-pFFUokh25LWsTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH] lxfb: Fix console blanking
Date: Wed, 9 Jul 2008 13:12:30 -0400
Message-ID: <20080709131230.748a8e73@fred>
References: <20080709163544.GC6809@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-geode-bounces-PfSpb0PWhxZc2C7mugBRk2EX/6BAtgUQ@public.gmane.org>
In-Reply-To: <20080709163544.GC6809-aftB2sG12IhaqnLngUycEA@public.gmane.org>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://bombadil.infradead.org/mailman/listinfo/linux-geode>, 
	<mailto:linux-geode-request-PfSpb0PWhxZc2C7mugBRk2EX/6BAtgUQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://bombadil.infradead.org/pipermail/linux-geode>
List-Post: <mailto:linux-geode-PfSpb0PWhxZc2C7mugBRk2EX/6BAtgUQ@public.gmane.org>
List-Help: <mailto:linux-geode-request-PfSpb0PWhxZc2C7mugBRk2EX/6BAtgUQ@public.gmane.org?subject=help>
List-Subscribe: <http://bombadil.infradead.org/mailman/listinfo/linux-geode>, 
	<mailto:linux-geode-request-PfSpb0PWhxZc2C7mugBRk2EX/6BAtgUQ@public.gmane.org?subject=subscribe>
Sender: linux-geode-bounces-PfSpb0PWhxZc2C7mugBRk2EX/6BAtgUQ@public.gmane.org
Errors-To: linux-geode-bounces-PfSpb0PWhxZc2C7mugBRk2EX/6BAtgUQ@public.gmane.org
To: Jordan Crouse <jordan.crouse-5C7GfCeVMHo@public.gmane.org>
Cc: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-geode-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org

On Wed, 9 Jul 2008 10:35:44 -0600
Jordan Crouse <jordan.crouse-5C7GfCeVMHo@public.gmane.org> wrote:

> The attached patch fixes console blanking in the Geode LX framebuffer.
> The current code blanks the DACs, but that does not appear to be
> enough to actually blank the screen (some characters remain visible).
> 
> The new code turns off the CRT enable bit for all modes, which forces
> blanking.  Also, to save power the DAC is powered down in the more 
> aggressive blanking modes.  
> 

Acked-by: Andres Salomon <dilinger-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
