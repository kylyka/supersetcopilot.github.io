# Superset Copilot Website Setup Guide

## Current Status

### ✅ Repository Files (Ready)
- ✅ `CNAME` file exists with correct value: `supersetcopilot.eu`
- ✅ `index.html` exists with required text: "Superset Copilot – aktivní"
- ✅ Repository is Public (accessible via GitHub API)

### ❌ Required Configuration (Not Yet Complete)

#### 1. GitHub Pages Configuration
**Status:** Not configured - files are only on feature branch

**Required Steps:**
1. Merge this PR to create/update the `main` branch
2. Go to repository Settings → Pages
3. Configure:
   - **Source:** Deploy from a branch
   - **Branch:** main
   - **Folder:** / (root)
4. Save the configuration

**Note:** GitHub Pages will automatically deploy from the `main` branch once configured.

#### 2. DNS Configuration
**Status:** Domain DNS not configured

**Required DNS Records for `supersetcopilot.eu`:**

Add the following A records:
```
supersetcopilot.eu.  A  185.199.108.153
supersetcopilot.eu.  A  185.199.109.153
supersetcopilot.eu.  A  185.199.110.153
supersetcopilot.eu.  A  185.199.111.153
```

**Optional TXT Record (for GitHub verification if required):**
```
supersetcopilot.eu.  TXT  "github-verification=..."
```
(The verification code will be provided by GitHub in Settings → Pages when you configure the custom domain)

#### 3. GitHub Pages Custom Domain Setup
**After DNS is configured:**
1. Go to Settings → Pages
2. Under "Custom domain", enter: `supersetcopilot.eu`
3. Click Save
4. Wait for DNS check to complete (may take a few minutes)
5. Enable "Enforce HTTPS" once SSL certificate is provisioned

## Verification Steps

### Step 1: Check GitHub Pages is Active
```bash
# The GitHub Pages URL should be accessible:
# https://kylyka.github.io/packy-ssow.github.io/
```

### Step 2: Check DNS Configuration
```bash
nslookup supersetcopilot.eu
# Should return the GitHub Pages A records

dig supersetcopilot.eu +short
# Should show:
# 185.199.108.153
# 185.199.109.153
# 185.199.110.153
# 185.199.111.153
```

### Step 3: Verify Website Content
```bash
curl https://supersetcopilot.eu
# Should return HTML containing "Superset Copilot – aktivní"
```

## Expected Final Result

When fully configured, visiting `https://supersetcopilot.eu` should display:
- Page title: "Superset Copilot"
- Heading: "Superset Copilot – aktivní"
- Content: "Web je úspěšně nasazen přes GitHub Pages."

## Troubleshooting

### Issue: 404 Not Found
- **Cause:** GitHub Pages not enabled or configured incorrectly
- **Solution:** Check Settings → Pages configuration

### Issue: DNS_PROBE_FINISHED_NXDOMAIN
- **Cause:** DNS records not configured
- **Solution:** Configure A records as specified above

### Issue: Certificate Error
- **Cause:** HTTPS not yet enabled or SSL certificate not provisioned
- **Solution:** Wait for GitHub to provision certificate (can take up to 24 hours after DNS configuration)

## Summary Checklist

- [ ] Merge PR to main branch
- [ ] Enable GitHub Pages (Settings → Pages → Deploy from branch: main)
- [ ] Configure DNS A records for supersetcopilot.eu
- [ ] Set custom domain in GitHub Pages settings
- [ ] Wait for DNS propagation (up to 48 hours)
- [ ] Enable HTTPS enforcement
- [ ] Verify website is accessible at https://supersetcopilot.eu
- [ ] Confirm page contains "Superset Copilot – aktivní"

## Contact

For questions or issues with this setup, please open an issue in the repository.
