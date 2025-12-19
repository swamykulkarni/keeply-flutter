# Use Python for simple HTTP server
FROM python:3.9-slim

# Set working directory
WORKDIR /app

# Create a simple HTML page
RUN echo '<!DOCTYPE html>' > index.html && \
    echo '<html>' >> index.html && \
    echo '<head>' >> index.html && \
    echo '  <meta charset="UTF-8">' >> index.html && \
    echo '  <meta name="viewport" content="width=device-width, initial-scale=1.0">' >> index.html && \
    echo '  <title>Keeply AMC Tracker - Flutter Mobile App</title>' >> index.html && \
    echo '  <style>' >> index.html && \
    echo '    body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; margin: 0; padding: 20px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; }' >> index.html && \
    echo '    .container { max-width: 900px; margin: 0 auto; background: white; border-radius: 20px; box-shadow: 0 20px 40px rgba(0,0,0,0.1); overflow: hidden; }' >> index.html && \
    echo '    .header { background: linear-gradient(135deg, #2196F3 0%, #21CBF3 100%); color: white; padding: 40px; text-align: center; }' >> index.html && \
    echo '    .logo { width: 100px; height: 100px; background: rgba(255,255,255,0.2); border-radius: 20px; margin: 0 auto 20px; display: flex; align-items: center; justify-content: center; font-size: 50px; }' >> index.html && \
    echo '    h1 { margin: 0; font-size: 2.5em; font-weight: 700; }' >> index.html && \
    echo '    .subtitle { margin: 10px 0 0 0; font-size: 1.2em; opacity: 0.9; }' >> index.html && \
    echo '    .content { padding: 40px; }' >> index.html && \
    echo '    .status { text-align: center; margin-bottom: 30px; padding: 15px; background: #e8f5e8; border-radius: 10px; color: #2e7d32; font-weight: 600; }' >> index.html && \
    echo '    .feature { margin: 25px 0; padding: 20px; background: #f8f9fa; border-radius: 12px; border-left: 5px solid #2196F3; }' >> index.html && \
    echo '    .feature h3 { margin: 0 0 10px 0; color: #1976D2; }' >> index.html && \
    echo '    .demo-note { background: linear-gradient(135deg, #e3f2fd 0%, #bbdefb 100%); padding: 25px; border-radius: 12px; margin: 25px 0; }' >> index.html && \
    echo '    .btn { display: inline-block; background: linear-gradient(135deg, #2196F3 0%, #21CBF3 100%); color: white; padding: 15px 30px; text-decoration: none; border-radius: 8px; margin: 10px 10px 10px 0; font-weight: 600; transition: transform 0.2s; }' >> index.html && \
    echo '    .btn:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(33,150,243,0.3); }' >> index.html && \
    echo '    .grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px; margin: 20px 0; }' >> index.html && \
    echo '    .card { background: white; border: 1px solid #e0e0e0; border-radius: 12px; padding: 20px; }' >> index.html && \
    echo '    .footer { text-align: center; color: #666; margin-top: 40px; padding: 20px; border-top: 1px solid #e0e0e0; }' >> index.html && \
    echo '    ul { padding-left: 20px; } li { margin: 8px 0; }' >> index.html && \
    echo '  </style>' >> index.html && \
    echo '</head>' >> index.html && \
    echo '<body>' >> index.html && \
    echo '  <div class="container">' >> index.html && \
    echo '    <div class="header">' >> index.html && \
    echo '      <div class="logo">📱</div>' >> index.html && \
    echo '      <h1>Keeply AMC Tracker</h1>' >> index.html && \
    echo '      <p class="subtitle">Flutter Mobile Application - Production Ready</p>' >> index.html && \
    echo '    </div>' >> index.html && \
    echo '    <div class="content">' >> index.html && \
    echo '      <div class="status">✅ Successfully Deployed to Railway!</div>' >> index.html && \
    echo '      <div class="feature">' >> index.html && \
    echo '        <h3>🚀 Complete Flutter Mobile Application</h3>' >> index.html && \
    echo '        <p>A comprehensive AMC (Annual Maintenance Contract) tracking solution built with Flutter. This is a <strong>native mobile application</strong> that can be deployed as Android APK, iOS app, or web application.</p>' >> index.html && \
    echo '      </div>' >> index.html && \
    echo '      <div class="grid">' >> index.html && \
    echo '        <div class="card">' >> index.html && \
    echo '          <h3>📱 Mobile Features</h3>' >> index.html && \
    echo '          <ul>' >> index.html && \
    echo '            <li>Native Android & iOS apps</li>' >> index.html && \
    echo '            <li>Material Design 3 UI</li>' >> index.html && \
    echo '            <li>Offline functionality</li>' >> index.html && \
    echo '            <li>Local data storage</li>' >> index.html && \
    echo '            <li>Smooth animations</li>' >> index.html && \
    echo '          </ul>' >> index.html && \
    echo '        </div>' >> index.html && \
    echo '        <div class="card">' >> index.html && \
    echo '          <h3>⚡ App Features</h3>' >> index.html && \
    echo '          <ul>' >> index.html && \
    echo '            <li>User authentication system</li>' >> index.html && \
    echo '            <li>AMC dashboard & statistics</li>' >> index.html && \
    echo '            <li>Appliance management</li>' >> index.html && \
    echo '            <li>Smart search & filtering</li>' >> index.html && \
    echo '            <li>Real-time notifications</li>' >> index.html && \
    echo '          </ul>' >> index.html && \
    echo '        </div>' >> index.html && \
    echo '      </div>' >> index.html && \
    echo '      <div class="demo-note">' >> index.html && \
    echo '        <h3>🎮 Demo Data Included</h3>' >> index.html && \
    echo '        <p><strong>Sample Appliances:</strong> 6 user appliances (Samsung, LG, Daikin) with realistic AMC tracking</p>' >> index.html && \
    echo '        <p><strong>Master Database:</strong> 10+ appliances from Indian market with complete specifications</p>' >> index.html && \
    echo '        <p><strong>Demo Credentials:</strong> Phone: <code>9876543210</code> | Password: <code>demo123</code></p>' >> index.html && \
    echo '      </div>' >> index.html && \
    echo '      <div class="feature">' >> index.html && \
    echo '        <h3>🏗️ Technical Stack</h3>' >> index.html && \
    echo '        <p><strong>Framework:</strong> Flutter 3.0+ with Dart<br>' >> index.html && \
    echo '        <strong>State Management:</strong> Provider pattern<br>' >> index.html && \
    echo '        <strong>Storage:</strong> SharedPreferences for local data<br>' >> index.html && \
    echo '        <strong>UI:</strong> Material Design 3 components<br>' >> index.html && \
    echo '        <strong>Architecture:</strong> MVVM with clean code structure</p>' >> index.html && \
    echo '      </div>' >> index.html && \
    echo '      <div style="text-align: center; margin: 40px 0;">' >> index.html && \
    echo '        <a href="https://github.com/swamykulkarni/keeply-flutter" class="btn">📂 View Source Code</a>' >> index.html && \
    echo '        <a href="https://github.com/swamykulkarni/keeply-flutter/blob/main/README.md" class="btn">📖 Documentation</a>' >> index.html && \
    echo '      </div>' >> index.html && \
    echo '      <div class="footer">' >> index.html && \
    echo '        <p><strong>Keeply AMC Tracker v1.0.0</strong><br>' >> index.html && \
    echo '        Flutter Mobile Application - Ready for Android, iOS & Web<br>' >> index.html && \
    echo '        <small>Deployed on Railway • Built with Flutter 3.0+ • Production Ready</small></p>' >> index.html && \
    echo '      </div>' >> index.html && \
    echo '    </div>' >> index.html && \
    echo '  </div>' >> index.html && \
    echo '</body>' >> index.html && \
    echo '</html>' >> index.html

# Expose port (Railway will assign the PORT environment variable)
EXPOSE 8080

# Start HTTP server on the port Railway provides
CMD python3 -m http.server ${PORT:-8080}